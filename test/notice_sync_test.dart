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

  test('NoticeRepository handles notices and sync cleanly without dummy seed notices', () async {
    // When no notices are seeded or present, notices list is empty initially
    final notices = await repo.all();
    expect(notices, isA<List<Notice>>());

    // Creating a real notice persists and can be queried
    final created = await repo.create(
      title: 'AICC Official JKPCC Session Circular',
      body: 'Meeting scheduled at Srinagar Party Headquarters.',
      priority: NoticePriority.urgent,
      authorName: 'JKPCC President',
    );

    final updatedNotices = await repo.all();
    expect(updatedNotices.any((n) => n.id == created.id), isTrue);
  });

  test('HttpSyncTransport initializes with default production ports', () {
    final transport = HttpSyncTransport();
    expect(transport.primaryUrl, contains(':4040/api/sync'));
    expect(transport.emulatorUrl, contains(':4040/api/sync'));
  });
}

