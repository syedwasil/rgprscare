import 'package:flutter/material.dart';

enum HelplineCategory {
  emergency,
  electricity,
  water,
  health,
  disaster,
  womenChild,
  partyHelpDesk,
}

class HelplineContact {
  const HelplineContact({
    required this.title,
    required this.subtitle,
    required this.phone,
    required this.category,
    this.alternatePhone,
    this.region = 'All J&K',
    this.is24x7 = true,
    this.icon = Icons.phone,
    this.isTollFree = true,
  });

  final String title;
  final String subtitle;
  final String phone;
  final HelplineCategory category;
  final String? alternatePhone;
  final String region;
  final bool is24x7;
  final IconData icon;
  final bool isTollFree;
}

const allHelplines = <HelplineContact>[
  // Universal Emergency
  HelplineContact(
    title: 'National Emergency Response (112)',
    subtitle: 'Police, Fire, and Ambulance combined emergency response',
    phone: '112',
    category: HelplineCategory.emergency,
    icon: Icons.emergency,
  ),
  HelplineContact(
    title: 'Free Emergency Ambulance (108)',
    subtitle: '24x7 emergency medical transport to nearest hospital',
    phone: '108',
    category: HelplineCategory.health,
    icon: Icons.local_hospital,
  ),
  HelplineContact(
    title: 'Pregnant Women & Infant Ambulance (102)',
    subtitle: 'Free hospital pickup and drop under JSSK',
    phone: '102',
    category: HelplineCategory.health,
    icon: Icons.child_friendly,
  ),

  // Electricity (PDD)
  HelplineContact(
    title: 'Electricity Breakdown & Faults (PDD J&K)',
    subtitle: 'Toll-free power outage and transformer breakdown control',
    phone: '1912',
    category: HelplineCategory.electricity,
    icon: Icons.bolt,
  ),
  HelplineContact(
    title: 'Kashmir Power Control Room (KPDCL)',
    subtitle: 'Srinagar and all Kashmir Valley electrical grievances',
    phone: '0194-2450213',
    alternatePhone: '0194-2455243',
    category: HelplineCategory.electricity,
    region: 'Kashmir Division',
    icon: Icons.electrical_services,
    isTollFree: false,
  ),
  HelplineContact(
    title: 'Jammu Power Control Room (JPDCL)',
    subtitle: 'Jammu province central electricity control room',
    phone: '0191-2479199',
    alternatePhone: '0191-2490878',
    category: HelplineCategory.electricity,
    region: 'Jammu Division',
    icon: Icons.electrical_services,
    isTollFree: false,
  ),

  // Water & Jal Shakti (PHE)
  HelplineContact(
    title: 'Jal Shakti (PHE) Kashmir Control',
    subtitle: 'Drinking water pipeline leakage, tanker request, contamination',
    phone: '0194-2452234',
    category: HelplineCategory.water,
    region: 'Kashmir Division',
    icon: Icons.water_drop,
    isTollFree: false,
  ),
  HelplineContact(
    title: 'Jal Shakti (PHE) Jammu Control',
    subtitle: 'Tubewell, pipeline, and clean drinking water complaints',
    phone: '0191-2544256',
    category: HelplineCategory.water,
    region: 'Jammu Division',
    icon: Icons.water_drop,
    isTollFree: false,
  ),

  // Disaster, Weather & Highway Traffic
  HelplineContact(
    title: 'NH-44 Highway Traffic Control (Ramban / Qazigund)',
    subtitle: 'Live status of Jammu-Srinagar Highway, landslide & convoy updates',
    phone: '0194-2450022',
    alternatePhone: '0191-2459048',
    category: HelplineCategory.disaster,
    icon: Icons.traffic,
    isTollFree: false,
  ),
  HelplineContact(
    title: 'State Disaster Response (SDRF J&K)',
    subtitle: 'Flood rescue, avalanche alerts, and heavy snowfall assistance',
    phone: '1070',
    category: HelplineCategory.disaster,
    icon: Icons.tsunami,
  ),
  HelplineContact(
    title: 'District Emergency Control Room (DDMA)',
    subtitle: 'Local DC office emergency response for storm/snow breakdown',
    phone: '1077',
    category: HelplineCategory.disaster,
    icon: Icons.warning_amber,
  ),

  // Women & Child Safety
  HelplineContact(
    title: 'Women Helpline J&K (181)',
    subtitle: '24x7 confidential support for domestic violence and distress',
    phone: '181',
    category: HelplineCategory.womenChild,
    icon: Icons.support_agent,
  ),
  HelplineContact(
    title: 'National Childline (1098)',
    subtitle: 'Child protection, missing child, and emergency child care',
    phone: '1098',
    category: HelplineCategory.womenChild,
    icon: Icons.family_restroom,
  ),
  HelplineContact(
    title: 'Cyber Crime Helpline (1930)',
    subtitle: 'Financial fraud, online cheating, and identity theft',
    phone: '1930',
    category: HelplineCategory.emergency,
    icon: Icons.security,
  ),

  // Congress Jan Seva Desks
  HelplineContact(
    title: 'INC J&K State Control Room (Srinagar HQ)',
    subtitle: 'Congress House, M.A. Road — Citizen grievance escalation & legal aid',
    phone: '0194-2452402',
    alternatePhone: '0194-2475001',
    category: HelplineCategory.partyHelpDesk,
    region: 'Kashmir Division',
    icon: Icons.back_hand,
    isTollFree: false,
  ),
  HelplineContact(
    title: 'INC J&K State Control Room (Jammu HQ)',
    subtitle: 'Congress Bhawan, Shaheedi Chowk — Public welfare & RTI help desk',
    phone: '0191-2544256',
    alternatePhone: '0191-2578500',
    category: HelplineCategory.partyHelpDesk,
    region: 'Jammu Division',
    icon: Icons.back_hand,
    isTollFree: false,
  ),
  HelplineContact(
    title: 'INC J&K Central Care & Jan Sunwai Desk',
    subtitle: 'Centralized citizen grievance redressal & RGPRS coordination',
    phone: '0194-2452402',
    category: HelplineCategory.partyHelpDesk,
    icon: Icons.support_agent,
    isTollFree: false,
  ),
];

