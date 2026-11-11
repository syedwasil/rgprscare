import 'package:flutter_riverpod/flutter_riverpod.dart';

class BloodBankCenter {
  const BloodBankCenter({
    required this.hospitalName,
    required this.district,
    required this.phone,
    required this.is24x7,
    required this.division,
  });

  final String hospitalName;
  final String district;
  final String phone;
  final bool is24x7;
  final String division;
}

const jkBloodBanks = <BloodBankCenter>[
  // ---- Kashmir Division (10 Districts) ----
  BloodBankCenter(
    hospitalName: 'SMHS Hospital Regional Blood Center',
    district: 'Srinagar',
    phone: '0194-2503111',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'SKIMS Soura Blood Transfusion Dept',
    district: 'Srinagar',
    phone: '0194-2401013',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Ganderbal',
    district: 'Ganderbal',
    phone: '0194-2416244',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Budgam',
    district: 'Budgam',
    phone: '01951-255235',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'GMC & Associated Hospital Blood Bank Anantnag',
    district: 'Anantnag',
    phone: '01932-222123',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Center Kulgam',
    district: 'Kulgam',
    phone: '01931-260232',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Pulwama',
    district: 'Pulwama',
    phone: '01933-241275',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Shopian',
    district: 'Shopian',
    phone: '01933-260999',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'GMC Associated Hospital Blood Bank Baramulla',
    district: 'Baramulla',
    phone: '01954-222214',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Kupwara',
    district: 'Kupwara',
    phone: '01955-252245',
    is24x7: true,
    division: 'Kashmir',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Bandipora',
    district: 'Bandipora',
    phone: '01957-225211',
    is24x7: true,
    division: 'Kashmir',
  ),

  // ---- Jammu Division (10 Districts) ----
  BloodBankCenter(
    hospitalName: 'GMC Hospital Central Blood Bank Jammu',
    district: 'Jammu',
    phone: '0191-2584283',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'SMGS Hospital Blood Bank Shalimar',
    district: 'Jammu',
    phone: '0191-2547635',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Samba',
    district: 'Samba',
    phone: '01923-243102',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'GMC Associated Hospital Blood Bank Kathua',
    district: 'Kathua',
    phone: '01922-234220',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Udhampur',
    district: 'Udhampur',
    phone: '01992-270222',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Reasi',
    district: 'Reasi',
    phone: '01991-245533',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'GMC Blood Bank Associated Hospital Rajouri',
    district: 'Rajouri',
    phone: '01962-263222',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Raja Sukhdev Singh Poonch',
    district: 'Poonch',
    phone: '01965-220144',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'GMC Associated Hospital Blood Bank Doda',
    district: 'Doda',
    phone: '01996-233215',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Ramban',
    district: 'Ramban',
    phone: '01998-266532',
    is24x7: true,
    division: 'Jammu',
  ),
  BloodBankCenter(
    hospitalName: 'District Hospital Blood Bank Kishtwar',
    district: 'Kishtwar',
    phone: '01995-259230',
    is24x7: true,
    division: 'Jammu',
  ),
];

class BloodSosRequest {
  const BloodSosRequest({
    required this.id,
    required this.patientName,
    required this.bloodGroup,
    required this.unitsNeeded,
    required this.hospitalName,
    required this.district,
    required this.contactPhone,
    required this.urgency,
    required this.createdAt,
  });

  final String id;
  final String patientName;
  final String bloodGroup;
  final int unitsNeeded;
  final String hospitalName;
  final String district;
  final String contactPhone;
  final String urgency;
  final DateTime createdAt;
}

final _initialSosRequests = <BloodSosRequest>[];

class BloodSosNotifier extends Notifier<List<BloodSosRequest>> {
  @override
  List<BloodSosRequest> build() => _initialSosRequests;

  void addRequest(BloodSosRequest req) {
    state = [req, ...state];
  }
}

final bloodSosProvider =
    NotifierProvider<BloodSosNotifier, List<BloodSosRequest>>(BloodSosNotifier.new);

