import 'package:flutter/material.dart';

enum SchemeCategory {
  health,
  pension,
  womenChild,
  rationFood,
  employment,
  farmers,
  housing,
  tribalRights,
}

class WelfareScheme {
  const WelfareScheme({
    required this.id,
    required this.title,
    required this.hindiTitle,
    this.urduTitle = '',
    required this.shortDescription,
    required this.fullBenefit,
    required this.category,
    required this.icon,
    required this.badge,
    required this.eligibilityCriteria,
    required this.requiredDocuments,
    required this.howToApply,
    required this.officialPortalOrOffice,
    required this.helpline,
  });

  final String id;
  final String title;
  final String hindiTitle;
  final String urduTitle;
  final String shortDescription;
  final String fullBenefit;
  final SchemeCategory category;
  final IconData icon;
  final String badge;
  final List<String> eligibilityCriteria;
  final List<String> requiredDocuments;
  final String howToApply;
  final String officialPortalOrOffice;
  final String helpline;
}

const allWelfareSchemes = <WelfareScheme>[
  WelfareScheme(
    id: 'mgnrega-job-card',
    title: 'Mahatma Gandhi NREGA (Congress Flagship Law)',
    hindiTitle: 'मनरेगा — 100 दिन का कानूनी अधिकार एवं बेरोजगारी भत्ता',
    urduTitle: 'منریگا — 100 دن قانونی روزگار و بیروزگاری الاؤنس (کانگریس قانونی حق)',
    shortDescription: '100 days of guaranteed legal wage work & unemployment allowance in your Halqa',
    fullBenefit:
        'Passed under Congress UPA government: Guarantees 100 days of statutory wage employment per rural household. If work is not provided within 15 days of dated application (Form 6), government must pay daily unemployment allowance.',
    category: SchemeCategory.employment,
    icon: Icons.construction,
    badge: 'CONGRESS LEGAL RIGHT',
    eligibilityCriteria: [
      'Any adult citizen (18+ years) residing in a rural Halqa Panchayat of J&K.',
      'Willing to do manual public work in the village.',
      'Legal right to receive dated receipt upon submitting work demand.',
      'Wage must be credited into bank account within 15 days of muster roll.',
    ],
    requiredDocuments: [
      'Aadhaar Card',
      'Passport size photograph',
      'Bank Account Passbook (Aadhaar linked)',
      'Job Card (Must be issued free of cost within 15 days)',
    ],
    howToApply:
        'Submit Form-6 (Work Demand) to your Panchayat Secretary (VLW) or BDO office. If denied work within 15 days, contact INC Jan Seva Desk to claim mandatory cash Unemployment Allowance.',
    officialPortalOrOffice: 'Halqa Panchayat Secretary / Block Development Officer (BDO)',
    helpline: '0194-2452402 (INC Jan Seva) / 1800-180-7045 (RDD)',
  ),

  WelfareScheme(
    id: 'nfsa-ration-rights',
    title: 'National Food Security Act (Congress Landmark Law)',
    hindiTitle: 'राष्ट्रीय खाद्य सुरक्षा कानून — हर गरीब का राशन अधिकार',
    urduTitle: 'نیشنل فوڈ سیکیورٹی ایکٹ — مفت و سستا راشن کا قانونی حق (کانگریس قانون)',
    shortDescription: 'Legal right to subsidized & free food grains (Rice & Wheat) for every family',
    fullBenefit:
        'Historic Congress legislation establishing food security as a legal right. Antyodaya (AAY) households receive 35 kg food grains per month, and Priority (PHH) households receive 5 kg per member per month at legally capped prices.',
    category: SchemeCategory.rationFood,
    icon: Icons.rice_bowl,
    badge: '35 KG / FAMILY',
    eligibilityCriteria: [
      'AAY: Poorest rural households, destitute elders, widows, and nomadic families.',
      'PHH: Low-income and marginalized families certified by Food & Civil Supplies.',
      'Non-Priority (NPHH): Subsidized food grains for all eligible family card holders.',
    ],
    requiredDocuments: [
      'Aadhaar Card of all family members',
      'Ration Card / Family Head State Subject or Domicile',
      'Income Certificate from Tehsildar (if applying for BPL/PHH endorsement)',
      'e-KYC biometric slip',
    ],
    howToApply:
        'Verify your quota online at jk.epds.nic.in. If the local fair price dealer cuts ration or overcharges, file an instant grievance via INC Care Desk to mandate immediate delivery.',
    officialPortalOrOffice: 'Tehsil Supply Officer (TSO) / jk.epds.nic.in',
    helpline: '1967 (Consumer Helpline) / 0194-2452402',
  ),

  WelfareScheme(
    id: 'fra-tribal-rights',
    title: 'Forest Rights Act (FRA 2006 — Congress Tribal Protection)',
    hindiTitle: 'वन अधिकार कानून (FRA) — गुर्जर-बकरवाल एवं वनवासियों के ज़मीनी अधिकार',
    urduTitle: 'جنگلاتی حقوق قانون (FRA 2006) — گجر، بکروال و قبائلی اراضی پٹہ (کانگریس دور)',
    shortDescription: 'Title deed (Patta) for traditional forest land & seasonal grazing rights',
    fullBenefit:
        'Pioneered by the Congress UPA Government to undo historic injustice to tribal and pastoralist communities. Grants individual legal land titles (up to 4 hectares) and collective community grazing rights for Gujjars, Bakerwals, and traditional forest dwellers.',
    category: SchemeCategory.tribalRights,
    icon: Icons.forest,
    badge: 'TRIBAL LAND PATTA',
    eligibilityCriteria: [
      'Members of Scheduled Tribes (ST) who primarily reside in forests or forest lands.',
      'Other Traditional Forest Dwellers (OTFD) with occupation proof for 3 generations (75 years).',
      'Families utilizing customary pasture lands (Dhar, Marg, Behak) for livestock grazing.',
    ],
    requiredDocuments: [
      'Scheduled Tribe (ST) Certificate or proof of 3 generations occupation',
      'Ration Card and Aadhaar',
      'Gram Sabha / Forest Rights Committee (FRC) resolution verification',
      'Customary grazing route / tax receipt (Kahcharai / Tirni receipt)',
    ],
    howToApply:
        'Submit claim form to the Village Forest Rights Committee (FRC) of your Gram Sabha. INC Tribal Rights Cell provides free legal assistance if Forest Department issues illegal eviction notices.',
    officialPortalOrOffice: 'Sub-Divisional Level Committee (SDLC) / Tehsildar',
    helpline: '0194-2452402 (INC Tribal Rights Desk)',
  ),

  WelfareScheme(
    id: 'isss-pension',
    title: 'Indira Gandhi Social Assistance & ISSS Pension',
    hindiTitle: 'सामाजिक सुरक्षा पेंशन योजना (वृद्धावस्था / विधवा / दिव्यांग)',
    urduTitle: 'اندرا گاندھی سماجی تحفظ پنشن — ₹1,000 ماہانہ براہِ راست بینک اکاؤنٹ',
    shortDescription: '₹1,000 monthly direct bank transfer for elderly, widows and specially-abled',
    fullBenefit:
        'Social security pension deposited via Direct Benefit Transfer (DBT) into the beneficiary\'s bank account to ensure financial dignity for elderly persons, destitute widows, and differently-abled citizens.',
    category: SchemeCategory.pension,
    icon: Icons.elderly,
    badge: '₹1,000 / MONTH',
    eligibilityCriteria: [
      'Old Age: Senior citizens aged 60+ years from economically vulnerable households.',
      'Widows: Destitute women aged 40+ who have lost their spouse.',
      'Specially-Abled (Divyang): Citizens with disability certificate of 40% or above.',
      'Annual family income below ₹75,000.',
    ],
    requiredDocuments: [
      'Aadhaar Card',
      'Age proof / School or Birth Certificate / Voter ID',
      'Disability Certificate from Chief Medical Officer (CMO)',
      'Death Certificate of spouse (for Widow pension)',
      'Income Certificate from Tehsildar',
      'Aadhaar-seeded bank passbook',
    ],
    howToApply:
        'Apply online at Jansugam portal (jansugam.jk.gov.in) or submit file at Tehsil Social Welfare Office (TSWO). If delayed, contact RGPRS "Pension Mitra" for biometric life-certificate assistance.',
    officialPortalOrOffice: 'Tehsil Social Welfare Officer (TSWO) / jansugam.jk.gov.in',
    helpline: '0194-2473628 (Kashmir) / 0191-2478400 (Jammu)',
  ),

  WelfareScheme(
    id: 'state-marriage-assistance',
    title: 'State Marriage Assistance Scheme (SMAS)',
    hindiTitle: 'विवाह सहायता योजना (गरीब कन्याओं के लिए)',
    urduTitle: 'اسٹیٹ میرج اسسٹنس اسکیم — بی پی ایل بیٹیوں کے لیے ₹50,000 نقد گرانٹ',
    shortDescription: '₹50,000 one-time financial grant for marriage of poor & BPL girls',
    fullBenefit:
        'Direct financial assistance grant of ₹50,000 credited to the bride\'s bank account prior to her wedding to relieve the burden on impoverished families.',
    category: SchemeCategory.womenChild,
    icon: Icons.volunteer_activism,
    badge: '₹50,000 ONE-TIME',
    eligibilityCriteria: [
      'Bride must be 18 years of age or older at the time of wedding.',
      'Family must belong to BPL / AAY household with annual income under ₹75,000.',
      'Application must be submitted at least 30 days prior to the wedding date.',
    ],
    requiredDocuments: [
      'Age Proof / Birth Certificate of the bride (18+ years)',
      'BPL / AAY Ration Card',
      'Aadhaar Card of the bride',
      'Income Certificate from Tehsildar',
      'Affidavit / Nikahnama / Wedding invitation certified by Halqa Panchayat / Imam / Pandit',
      'Bride\'s bank account passbook',
    ],
    howToApply:
        'Apply online at jansugam.jk.gov.in or submit file to District Social Welfare Officer (DSWO).',
    officialPortalOrOffice: 'District Social Welfare Officer (DSWO)',
    helpline: '0194-2452656 / 181',
  ),

  WelfareScheme(
    id: 'ladli-beti',
    title: 'Ladli Beti Financial Security Scheme',
    hindiTitle: 'लाडली बेटी योजना (बालिका वित्तीय सुरक्षा)',
    urduTitle: 'لاڈلی بیٹی اسکیم — ₹1,000 ماہانہ اور 21 سال پر ₹6.5 لاکھ روپے یکمشت',
    shortDescription: '₹1,000/month by Govt till age 14; ₹6.5 Lakhs payout at age 21',
    fullBenefit:
        'Deposits ₹1,000 per month into the girl child\'s account until age 14. Upon reaching 21 years of age, she receives a maturity amount of approx ₹6.50 Lakhs to fund higher education or self-reliance.',
    category: SchemeCategory.womenChild,
    icon: Icons.female,
    badge: '₹6.5+ LAKH MATURITY',
    eligibilityCriteria: [
      'Girl child born in Jammu & Kashmir in a family with annual income below ₹75,000.',
      'Application must be submitted within 6 months of delivery.',
    ],
    requiredDocuments: [
      'Birth Certificate from Municipality or Block Health Officer',
      'Income Certificate of father/guardian from Tehsildar',
      'Domicile / State Subject of parents',
      'Aadhaar of parents and infant',
      'Joint photo of girl child with mother',
    ],
    howToApply:
        'Submit application through the Anganwadi Worker (CDPO office) or District Social Welfare Office (DSWO).',
    officialPortalOrOffice: 'Child Development Project Officer (CDPO) / Anganwadi Centre',
    helpline: '181 (Women Helpline)',
  ),

  WelfareScheme(
    id: 'panchayati-raj-nyay',
    title: 'Rajiv Gandhi Panchayati Raj Guarantee (73rd Amendment)',
    hindiTitle: 'राजीव गांधी पंचायती राज न्याय गारंटी (73वाँ संशोधन)',
    urduTitle: 'راجیو گاندھی پنچایتی راج ضمانت (73ویں آئینی ترمیم) — بااختیار پنچایت',
    shortDescription: 'Constitutional empowerment of Sarpanches, direct untied village funds & Gram Sabha',
    fullBenefit:
        'Pioneered by former Prime Minister Rajiv Gandhi: Establishes three-tier grassroots democracy. Gives Halqa Panchayats full authority over 29 rural subjects, direct unhindered fund devolution from the Finance Commission, and power to verify all local government works.',
    category: SchemeCategory.employment,
    icon: Icons.account_balance,
    badge: 'RAJIV GANDHI VISION',
    eligibilityCriteria: [
      'Every adult villager has the constitutional right to vote in Halqa Panchayat elections.',
      'Gram Sabha has the supreme legal authority to approve village works and beneficiary lists.',
      'Sarpanches and Panches have statutory powers over local schools, health sub-centers, and village roads.',
    ],
    requiredDocuments: [
      'Voter Card / Domicile Certificate',
      'Gram Sabha resolution signed by villagers',
    ],
    howToApply:
        'Panchayati representatives and citizens can access RGPRS training manuals, legal protection, and honorarium grievance escalation through this app.',
    officialPortalOrOffice: 'Rajiv Gandhi Panchayati Raj Sangathan (RGPRS) State Desk',
    helpline: '0194-2452402',
  ),
];
