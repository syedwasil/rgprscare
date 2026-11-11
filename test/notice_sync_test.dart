import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rgprs_jk/data/notice/notice_data.dart';
import 'package:rgprs_jk/data/sync/sync_data.dart';
import 'package:rgprs_jk/db/app_database.dart';

void main() {
  late AppDatabase db;
  late SyncOutboxWriter outbox;
  late DriftNoticeRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    outbox = SyncOutboxWriter(db);
    repo = DriftNoticeRepository(db, outbox);
  });

  tearDown(() async {
    await db.close();
  });

  test('NoticeRepository auto-seeds official authentic public circulars on first launch', () async {
    final notices = await repo.all();
    expect(notices.length, greaterThanOrEqualTo(3));

    final winterSos = notices.firstWhere((n) => n.id == 'ntc-winter-sos-01');
    expect(winterSos.title, contains('Chilla-i-Kalan Emergency Snow Clearance'));
    expect(winterSos.priority, equals(NoticePriority.urgent));

    final meterNotice = notices.firstWhere((n) => n.id == 'ntc-meter-dispute-02');
    expect(meterNotice.title, contains('Smart Meter Billing Grievances'));
  });

  test('HttpSyncTransport initializes with default production ports', () {
    final transport = HttpSyncTransport();
    expect(transport.primaryUrl, contains(':4040/api/sync'));
    expect(transport.emulatorUrl, contains(':4040/api/sync'));
  });
}

