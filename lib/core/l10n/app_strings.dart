import 'package:flutter/widgets.dart';

/// Hand-rolled strings for English, Hindi and Urdu.
///
/// Deliberately not `flutter gen-l10n`: the app needs three script systems
/// (Latin, Devanagari, Nastaliq) and full RTL for Urdu from day one, and a
/// plain map keeps the tables diff-able and unit-testable.
/// `test/l10n_test.dart` fails if the three tables ever drift apart.
class AppStrings {
  const AppStrings(this.locale);

  /// BCP-47 language code this instance serves.
  final String locale;

  static const supportedLanguageCodes = <String>['en', 'hi', 'ur'];
  static const fallbackLanguageCode = 'en';

  static bool isSupported(String code) => supportedLanguageCodes.contains(code);

  /// Looks up [key]; falls back to English, then to the key itself so the UI
  /// can never render a null or crash.
  String t(String key) =>
      _strings[locale]?[key] ?? _strings[fallbackLanguageCode]?[key] ?? key;

  String get appName => t('appName');
  String get tagline => t('tagline');
  String get home => t('home');
  String get organisation => t('organisation');
  String get notices => t('notices');
  String get profile => t('profile');
  String get language => t('language');
  String get divisions => t('divisions');
  String get districts => t('districts');
  String get blocks => t('blocks');
  String get halqas => t('halqas');
  String get wards => t('wards');
  String get members => t('members');
  String get verified => t('verified');
  String get pending => t('pending');
  String get offline => t('offline');
  String get noUnits => t('noUnits');
  String get loading => t('loading');
  String get searchHint => t('searchHint');
  String get noticesEmpty => t('noticesEmpty');
  String get welcome => t('welcome');
  String get aboutApp => t('aboutApp');
  String get aboutBody => t('aboutBody');
  String get unitType => t('unitType');
  String get routeNotFound => t('routeNotFound');
  String get dbErrorTitle => t('dbErrorTitle');
  String get jammuKashmir => t('jammuKashmir');
  String get kashmirDivision => t('kashmirDivision');
  String get jammuDivision => t('jammuDivision');

  // ---- Jan Sunwai (grievances) -------------------------------------------
  String get grievances => t('grievances');
  String get newGrievance => t('newGrievance');
  String get noGrievances => t('noGrievances');
  String get grievanceTitle => t('grievanceTitle');
  String get grievanceDescription => t('grievanceDescription');
  String get category => t('category');
  String get area => t('area');
  String get areaHint => t('areaHint');
  String get selectArea => t('selectArea');
  String get reportedBy => t('reportedBy');
  String get optional => t('optional');
  String get submit => t('submit');
  String get refCode => t('refCode');
  String get status => t('status');
  String get history => t('history');
  String get addNote => t('addNote');
  String get startWork => t('startWork');
  String get markResolved => t('markResolved');
  String get resolveBy => t('resolveBy');
  String get escalatedBlock => t('escalatedBlock');
  String get escalatedDistrict => t('escalatedDistrict');
  String get filterAll => t('filterAll');
  String get titleRequired => t('titleRequired');
  String get descriptionRequired => t('descriptionRequired');
  String get phoneInvalid => t('phoneInvalid');
  String get noteHint => t('noteHint');
  String get filedOn => t('filedOn');
  String get categoryWater => t('categoryWater');
  String get categoryRoad => t('categoryRoad');
  String get categoryElectricity => t('categoryElectricity');
  String get categoryRations => t('categoryRations');
  String get categoryMgnrega => t('categoryMgnrega');
  String get categoryPension => t('categoryPension');
  String get categoryHealth => t('categoryHealth');
  String get categoryOther => t('categoryOther');
  String get statusOpen => t('statusOpen');
  String get statusInProgress => t('statusInProgress');
  String get statusResolved => t('statusResolved');
  String get statusClosed => t('statusClosed');
  String get eventCreated => t('eventCreated');
  String get eventStatusChange => t('eventStatusChange');
  String get eventNote => t('eventNote');

  // ---- Membership -------------------------------------------------------
  String get myCard => t('myCard');
  String get joinRgprs => t('joinRgprs');
  String get fullName => t('fullName');
  String get phone => t('phone');
  String get role => t('role');
  String get memberCode => t('memberCode');
  String get noCard => t('noCard');
  String get cardNote => t('cardNote');
  String get nameRequired => t('nameRequired');
  String get roleCitizen => t('roleCitizen');
  String get roleVolunteer => t('roleVolunteer');
  String get roleWorker => t('roleWorker');
  String get rolePanch => t('rolePanch');
  String get roleSarpanch => t('roleSarpanch');
  String get roleBdc => t('roleBdc');
  String get roleDdc => t('roleDdc');
  String get editProfile => t('editProfile');

  // ---- Notices ----------------------------------------------------------
  String get composeNotice => t('composeNotice');
  String get noticeTitle => t('noticeTitle');
  String get noticeBody => t('noticeBody');
  String get noticeEmpty => t('noticeEmpty');
  String get audience => t('audience');
  String get allUnits => t('allUnits');
  String get priorityNormal => t('priorityNormal');
  String get priorityUrgent => t('priorityUrgent');
  String get authoredBy => t('authoredBy');
  String get composeNeedsRole => t('composeNeedsRole');

  // ---- Sync -------------------------------------------------------------
  String get syncTitle => t('syncTitle');
  String get syncPending => t('syncPending');
  String get syncNone => t('syncNone');

  /// Typical use: `final s = AppStrings.of(context);` then `s.home`.
  static AppStrings of(BuildContext context) =>
      Localizations.of<AppStrings>(context, AppStrings) ??
      const AppStrings(fallbackLanguageCode);

  /// Convenience for tests and the language switcher.
  static const languageNames = <String, String>{
    'en': 'English',
    'hi': 'हिन्दी',
    'ur': 'اردو',
  };

  /// The raw tables, for `test/l10n_test.dart` only.
  @visibleForTesting
  static const Map<String, Map<String, String>> testTables = _strings;

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'appName': 'RGPRS J&K',
      'tagline': 'Panchayati Raj Sangathan · Jammu & Kashmir',
      'home': 'Home',
      'organisation': 'Organisation',
      'notices': 'Notices',
      'profile': 'Profile',
      'language': 'Language',
      'divisions': 'Divisions',
      'districts': 'Districts',
      'blocks': 'Blocks',
      'halqas': 'Halqa Panchayats',
      'wards': 'Wards',
      'members': 'Members',
      'verified': 'Verified',
      'pending': 'Pending',
      'offline': 'Offline — changes will sync when you reconnect',
      'noUnits':
          'Grassroots RGPRS unit active. Contact DCC or State Coordination Desk for local assistance.',
      'loading': 'Loading…',
      'searchHint': 'Search district or panchayat',
      'noticesEmpty': 'Notices from the state unit will appear here.',
      'welcome': 'Welcome',
      'aboutApp': 'About this app',
      'aboutBody':
          'RGPRS J&K connects panchayati raj representatives, office bearers '
          'and workers of the Indian National Congress across Jammu & Kashmir.',
      'unitType': 'Level',
      'routeNotFound': 'That screen could not be found.',
      'dbErrorTitle': 'Local storage could not be started',
      'jammuKashmir': 'Jammu & Kashmir',
      'kashmirDivision': 'Kashmir Division',
      'jammuDivision': 'Jammu Division',

      'grievances': 'Grievances',
      'newGrievance': 'File a grievance',
      'noGrievances': 'No grievances filed yet.',
      'grievanceTitle': 'Issue',
      'grievanceDescription': 'Details',
      'category': 'Category',
      'area': 'Area',
      'areaHint': 'District for now — halqa once master data is loaded',
      'selectArea': 'Select district',
      'reportedBy': 'Reported by',
      'optional': 'optional',
      'submit': 'Submit',
      'refCode': 'Reference',
      'status': 'Status',
      'history': 'History',
      'addNote': 'Add note',
      'startWork': 'Start work',
      'markResolved': 'Mark resolved',
      'resolveBy': 'Resolve by',
      'escalatedBlock': 'Escalated to Block',
      'escalatedDistrict': 'Escalated to District',
      'filterAll': 'All',
      'titleRequired': 'Describe the issue in a few words',
      'descriptionRequired': 'Add a short description',
      'phoneInvalid': 'Enter a 10-digit mobile number',
      'noteHint': 'What happened?',
      'filedOn': 'Filed on',
      'categoryWater': 'Water & drinking supply',
      'categoryRoad': 'Roads & drainage',
      'categoryElectricity': 'Electricity',
      'categoryRations': 'Ration & PDS',
      'categoryMgnrega': 'MGNREGA wages',
      'categoryPension': 'Pension',
      'categoryHealth': 'Health services',
      'categoryOther': 'Other',
      'statusOpen': 'Open',
      'statusInProgress': 'In progress',
      'statusResolved': 'Resolved',
      'statusClosed': 'Closed',
      'eventCreated': 'Filed',
      'eventStatusChange': 'Status changed',
      'eventNote': 'Note',

      'myCard': 'My membership card',
      'joinRgprs': 'Join RGPRS',
      'fullName': 'Full name',
      'phone': 'Mobile number',
      'role': 'Role',
      'memberCode': 'Member ID',
      'noCard': 'No membership card yet — join to get one.',
      'cardNote':
          'Offline card. Verification is done by your Block office bearer '
          'once the app syncs.',
      'nameRequired': 'Enter your name',
      'roleCitizen': 'Citizen Member (Public)',
      'roleVolunteer': 'Panchayat Seva Volunteer',
      'roleWorker': 'Primary Party Member',
      'rolePanch': 'Panch',
      'roleSarpanch': 'Sarpanch',
      'roleBdc': 'BDC member',
      'roleDdc': 'DDC member',
      'editProfile': 'Update details',

      'composeNotice': 'Compose notice',
      'noticeTitle': 'Title',
      'noticeBody': 'Message',
      'noticeEmpty': 'No notices yet.',
      'audience': 'For',
      'allUnits': 'All units',
      'priorityNormal': 'Normal',
      'priorityUrgent': 'Urgent',
      'authoredBy': 'From',
      'composeNeedsRole': 'Only office bearers can send notices.',

      'syncTitle': 'Sync',
      'syncPending': 'Changes waiting to sync',
      'syncNone': 'Everything is synced',
    },
    'hi': {
      'appName': 'RGPRS J&K',
      'tagline': 'पंचायती राज संगठन · जम्मू और कश्मीर',
      'home': 'होम',
      'organisation': 'संगठन',
      'notices': 'सूचनाएँ',
      'profile': 'प्रोफ़ाइल',
      'language': 'भाषा',
      'divisions': 'मंडल',
      'districts': 'ज़िले',
      'blocks': 'ब्लॉक',
      'halqas': 'हलका पंचायतें',
      'wards': 'वार्ड',
      'members': 'सदस्य',
      'verified': 'सत्यापित',
      'pending': 'लंबित',
      'offline': 'ऑफ़लाइन — दोबारा जुड़ने पर बदलाव सिंक हो जाएँगे',
      'noUnits':
          'सक्रिय जमीनी आरजीपीआरएस इकाई। स्थानीय सहायता के लिए डीसीसी या राज्य समन्वय डेस्क से संपर्क करें।',
      'loading': 'लोड हो रहा है…',
      'searchHint': 'ज़िला या पंचायत खोजें',
      'noticesEmpty': 'राज्य इकाई की सूचनाएँ यहाँ दिखेंगी।',
      'welcome': 'स्वागत है',
      'aboutApp': 'इस ऐप के बारे में',
      'aboutBody':
          'RGPRS J&K जम्मू और कश्मीर में भारतीय राष्ट्रीय कांग्रेस के '
          'पंचायती राज प्रतिनिधियों, पदाधिकारियों और कार्यकर्ताओं को जोड़ता है।',
      'unitType': 'स्तर',
      'routeNotFound': 'यह स्क्रीन नहीं मिली।',
      'dbErrorTitle': 'स्थानीय स्टोरेज शुरू नहीं हो सका',
      'jammuKashmir': 'जम्मू और कश्मीर',
      'kashmirDivision': 'कश्मीर मंडल',
      'jammuDivision': 'जम्मू मंडल',

      'grievances': 'शिकायतें',
      'newGrievance': 'शिकायत दर्ज करें',
      'noGrievances': 'अभी कोई शिकायत दर्ज नहीं है।',
      'grievanceTitle': 'समस्या',
      'grievanceDescription': 'विवरण',
      'category': 'श्रेणी',
      'area': 'क्षेत्र',
      'areaHint': 'अभी ज़िला — मास्टर डेटा के बाद हलका',
      'selectArea': 'ज़िला चुनें',
      'reportedBy': 'रिपोर्ट करने वाला',
      'optional': 'वैकल्पिक',
      'submit': 'जमा करें',
      'refCode': 'संदर्भ',
      'status': 'स्थिति',
      'history': 'इतिहास',
      'addNote': 'टिप्पणी जोड़ें',
      'startWork': 'कार्रवाई शुरू करें',
      'markResolved': 'हल करें',
      'resolveBy': 'समाधान की अंतिम तिथि',
      'escalatedBlock': 'ब्लॉक को भेजा गया',
      'escalatedDistrict': 'ज़िलामुख्यालय को भेजा गया',
      'filterAll': 'सभी',
      'titleRequired': 'समस्या कुछ शब्दों में लिखें',
      'descriptionRequired': 'थोड़ा विवरण जोड़ें',
      'phoneInvalid': '10 अंकों का मोबाइल नंबर डालें',
      'noteHint': 'क्या हुआ?',
      'filedOn': 'दायर तिथि',
      'categoryWater': 'पानी और पेयजल',
      'categoryRoad': 'सड़क और निकासी',
      'categoryElectricity': 'बिजली',
      'categoryRations': 'राशन और पीडीएस',
      'categoryMgnrega': 'मनरेगा मज़दूरी',
      'categoryPension': 'पेंशन',
      'categoryHealth': 'स्वास्थ्य सेवाएँ',
      'categoryOther': 'अन्य',
      'statusOpen': 'खुली',
      'statusInProgress': 'कार्रवाई जारी',
      'statusResolved': 'हल हुई',
      'statusClosed': 'बंद',
      'eventCreated': 'दायर',
      'eventStatusChange': 'स्थिति बदली',
      'eventNote': 'टिप्पणी',

      'myCard': 'मेरी सदस्यता पर्ची',
      'joinRgprs': 'आरजीपीआरएस से जुड़ें',
      'fullName': 'पूरा नाम',
      'phone': 'मोबाइल नंबर',
      'role': 'पद',
      'memberCode': 'सदस्य आईडी',
      'noCard': 'अभी सदस्यता पर्ची नहीं है — जुड़कर बनवाएँ।',
      'cardNote':
          'यह ऑफ़लाइन पर्ची है। ऐप के सिंक होने पर आपके ब्लॉक पदाधिकारी '
          'सत्यापन करेंगे।',
      'nameRequired': 'अपना नाम लिखें',
      'roleCitizen': 'नागरिक सदस्य (जनता)',
      'roleVolunteer': 'पंचायत सेवा स्वयंसेवक',
      'roleWorker': 'प्राथमिक पार्टी सदस्य',
      'rolePanch': 'पंच',
      'roleSarpanch': 'सरपंच',
      'roleBdc': 'बीडीसी सदस्य',
      'roleDdc': 'डीडीसी सदस्य',
      'editProfile': 'विवरण बदलें',

      'composeNotice': 'सूचना लिखें',
      'noticeTitle': 'शीर्षक',
      'noticeBody': 'संदेश',
      'noticeEmpty': 'अभी कोई सूचना नहीं है।',
      'audience': 'किसके लिए',
      'allUnits': 'सभी इकाइयाँ',
      'priorityNormal': 'सामान्य',
      'priorityUrgent': 'अत्यावश्यक',
      'authoredBy': 'से',
      'composeNeedsRole': 'सूचना केवल पदाधिकारी भेज सकते हैं।',

      'syncTitle': 'सिंक',
      'syncPending': 'सिंक की प्रतीक्षा में बदलाव',
      'syncNone': 'सब कुछ सिंक हो गया',
    },
    'ur': {
      'appName': 'RGPRS J&K',
      'tagline': 'پنجایتی راج تنظیم · جموں و کشمیر',
      'home': 'ہوم',
      'organisation': 'تنظیم',
      'notices': 'اطلاعات',
      'profile': 'پروفائل',
      'language': 'زبان',
      'divisions': 'شعبے',
      'districts': 'ضلع',
      'blocks': 'بلوک',
      'halqas': 'حلقہ پنچایتیں',
      'wards': 'ورڈز',
      'members': 'ارکان',
      'verified': 'تصدیق شدہ',
      'pending': 'زیرِ التواء',
      'offline': 'آف لائن — دوبارہ آن ہونے پر تبدیلیاں محفوظ ہو جائیں گی',
      'noUnits':
          'سرگرم بنیادی آر جی پی آر ایس یونٹ۔ مقامی مدد کے لیے ڈی سی سی یا ریاستی رابطہ ڈیسک سے رابطہ کریں۔',
      'loading': 'لوڈ ہو رہا ہے…',
      'searchHint': 'ضلع یا پنچایت تلاش کریں',
      'noticesEmpty': 'ریاستی یونٹ کی اطلاعات یہاں آئیں گی۔',
      'welcome': 'خوش آمدید',
      'aboutApp': 'اس ایپ کے بارے میں',
      'aboutBody':
          'RGPRS J&K جموں و کشمیر میں بھارتی راشٹری کانگریس کے پنجایتی راج '
          'نمائندوں، عہدیداروں اور کارکنوں کو جوڑتا ہے۔',
      'unitType': 'درجہ',
      'routeNotFound': 'یہ اسکرین نہیں ملی۔',
      'dbErrorTitle': 'مقامی سٹوریج شروع نہیں ہو سکی',
      'jammuKashmir': 'جموں و کشمیر',
      'kashmirDivision': 'کشمیر شعبہ',
      'jammuDivision': 'جموں شعبہ',

      'grievances': 'شکایات',
      'newGrievance': 'شکایت درج کریں',
      'noGrievances': 'ابھی کوئی شکایت درج نہیں ہے۔',
      'grievanceTitle': 'مسئلہ',
      'grievanceDescription': 'تفصیل',
      'category': 'زمرہ',
      'area': 'علاقہ',
      'areaHint': 'ابھی ضلع — ماسٹر ڈیٹا کے بعد حلقہ',
      'selectArea': 'ضلع منتخب کریں',
      'reportedBy': 'راپتہ دہندہ',
      'optional': 'اختیاری',
      'submit': 'جمع کریں',
      'refCode': 'حوالہ',
      'status': 'حالت',
      'history': 'تاریخچہ',
      'addNote': 'نوٹ شامل کریں',
      'startWork': 'کارروائی شروع کریں',
      'markResolved': 'حل کریں',
      'resolveBy': 'حل کی آخری تاریخ',
      'escalatedBlock': 'بلک کو بھیجا گیا',
      'escalatedDistrict': 'ضلع مرکز کو بھیجا گیا',
      'filterAll': 'تمام',
      'titleRequired': 'مسئلہ چند الفاظ میں لکھیں',
      'descriptionRequired': 'مختصر تفصیل شامل کریں',
      'phoneInvalid': '10 ہندسوں کا موبائل نمبر درج کریں',
      'noteHint': 'کیا ہوا؟',
      'filedOn': 'داخلہ تاریخ',
      'categoryWater': 'پینے کا پانی',
      'categoryRoad': 'سرکیں و نکاسی',
      'categoryElectricity': 'بجلی',
      'categoryRations': 'راشن و پی ڈی ایس',
      'categoryMgnrega': 'منریگا اجرت',
      'categoryPension': 'پنشن',
      'categoryHealth': 'صحت خدمات',
      'categoryOther': 'دیگر',
      'statusOpen': 'کھلی',
      'statusInProgress': 'کارروائی جاری',
      'statusResolved': 'حل شدہ',
      'statusClosed': 'بند',
      'eventCreated': 'داخل کیا',
      'eventStatusChange': 'حالت بدلی',
      'eventNote': 'نوٹ',

      'myCard': 'میری رکنیت کارڈ',
      'joinRgprs': 'آر جی پی آر ای سے جڑیں',
      'fullName': 'پورا نام',
      'phone': 'موبائل نمبر',
      'role': 'عہدہ',
      'memberCode': 'رکن شناخت',
      'noCard': 'ابھی رکنیت کارڈ نہیں ہے — جڑ کر بنائیں۔',
      'cardNote':
          'یہ آف لائن کارڈ ہے۔ ایپ کے سنک ہونے پر آپ کے بلک عہدیدار '
          'تصدیق کریں گے۔',
      'nameRequired': 'اپنا نام لکھیں',
      'roleCitizen': 'شہری رکن (عوام)',
      'roleVolunteer': 'پنچایت خدمت رضا کار',
      'roleWorker': 'بنیادی پارٹی رکن',
      'rolePanch': 'پنچ',
      'roleSarpanch': 'سرپنچ',
      'roleBdc': 'بی ڈی سی رکن',
      'roleDdc': 'ڈی ڈی سی رکن',
      'editProfile': 'تفصیلات تبدیل کریں',

      'composeNotice': 'اطلاعہ لکھیں',
      'noticeTitle': 'عنوان',
      'noticeBody': 'پیغام',
      'noticeEmpty': 'ابھی کوئی اطلاعہ نہیں ہے۔',
      'audience': 'کس کے لیے',
      'allUnits': 'تمام اکائیاں',
      'priorityNormal': 'عام',
      'priorityUrgent': 'انتہائی ضروری',
      'authoredBy': 'سے',
      'composeNeedsRole': 'اطلاعات صرف عہدیدار بھیج سکتے ہیں۔',

      'syncTitle': 'سنک',
      'syncPending': 'سنک کا انتظار کرتی تبدیلیاں',
      'syncNone': 'سب کچھ سنک ہو گیا',
    },
  };
}

class AppStringsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppStringsDelegate();

  @override
  bool isSupported(Locale locale) => AppStrings.isSupported(locale.languageCode);

  @override
  Future<AppStrings> load(Locale locale) async => AppStrings(locale.languageCode);

  @override
  bool shouldReload(AppStringsDelegate old) => false;
}
