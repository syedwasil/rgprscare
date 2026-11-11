import 'package:flutter/material.dart';

import '../../core/action_utils.dart';
import '../../core/theme/app_theme.dart';

class MountainPass {
  const MountainPass({
    required this.name,
    required this.connects,
    required this.status, // 'Open', 'Snowbound / Closed', '4x4 Only'
    required this.altitude,
    required this.advisory,
    required this.controlRoomPhone,
  });

  final String name;
  final String connects;
  final String status;
  final String altitude;
  final String advisory;
  final String controlRoomPhone;
}

const mountainPassesList = <MountainPass>[
  MountainPass(
    name: 'NH-44 Jammu–Srinagar National Highway',
    connects: 'Jammu ↔ Udhampur ↔ Ramban ↔ Qazigund ↔ Srinagar',
    status: 'Open (Regulated Traffic)',
    altitude: 'Navyug Tunnel (1,790 m)',
    advisory: 'Heavy vehicle movement regulated at Mehar / Cafeteria Morh. Check convoy timing before leaving Nagrota / Qazigund.',
    controlRoomPhone: '0191-2459048',
  ),
  MountainPass(
    name: 'Razdan Pass (رازدان پاس)',
    connects: 'Bandipora ↔ Gurez Valley (Dawar)',
    status: 'Snowbound (4x4 with Chains)',
    altitude: '3,557 m (11,672 ft)',
    advisory: 'Heavy snow and ice accumulation near top. Anti-skid chains mandatory from Tragbal to Zingbal.',
    controlRoomPhone: '01957-225211',
  ),
  MountainPass(
    name: 'Sadhna Pass / Nastachun (سادھنا پاس)',
    connects: 'Kupwara ↔ Karnah / Tangdhar & Teetwal',
    status: 'Open for Light Vehicles',
    altitude: '3,130 m (10,269 ft)',
    advisory: 'Subject to sudden blizzards. Border Roads Organisation (Beacon) snow clearance active.',
    controlRoomPhone: '01955-252245',
  ),
  MountainPass(
    name: 'Sinthan Top (سنتھن ٹاپ)',
    connects: 'Anantnag (Kokernag) ↔ Kishtwar (Chhatroo)',
    status: 'Closed due to Snow',
    altitude: '3,784 m (12,414 ft)',
    advisory:
        'Heavy winter snow closure. Alternative route via Batote-Doda Highway.',
    controlRoomPhone: '01995-259230',
  ),
  MountainPass(
    name: 'Mughal Road (مغل روڈ)',
    connects: 'Shopian (Kashmir) ↔ Bafliaz / Poonch / Rajouri',
    status: 'Winter Closure',
    altitude: 'Peer Ki Gali (3,500 m)',
    advisory: 'Accumulated snow and frost on Peer Ki Gali stretch. Reopening in Spring season.',
    controlRoomPhone: '01933-260999',
  ),
  MountainPass(
    name: 'Zojila Pass (زوجیلا پاس)',
    connects: 'Sonamarg / Ganderbal ↔ Drass / Kargil',
    status: 'Regulated / Convoy',
    altitude: '3,528 m (11,575 ft)',
    advisory: 'Project Beacon and Vijayak snow clearing. Strict timing enforcement at Baltal gate.',
    controlRoomPhone: '0194-2416244',
  ),
];

class BusSchedule {
  const BusSchedule({
    required this.route,
    required this.departureTime,
    required this.origin,
    required this.destination,
    required this.busType,
    required this.fare,
  });

  final String route;
  final String departureTime;
  final String origin;
  final String destination;
  final String busType;
  final String fare;
}

const jksrtcBusRoutes = <BusSchedule>[
  BusSchedule(
    route: 'Srinagar to Jammu Super Deluxe',
    departureTime: '06:30 AM & 07:00 AM (Daily)',
    origin: 'TRC Srinagar',
    destination: 'General Bus Stand Jammu',
    busType: 'JKSRTC Deluxe / AC',
    fare: '₹550',
  ),
  BusSchedule(
    route: 'Kupwara to Tangdhar (Karnah)',
    departureTime: '07:30 AM & 11:00 AM',
    origin: 'Kupwara Main Bus Stand',
    destination: 'Tangdhar Market',
    busType: 'Mountain 4x4 Bus',
    fare: '₹140',
  ),
  BusSchedule(
    route: 'Bandipora to Dawar (Gurez Valley)',
    departureTime: '08:00 AM (Weather Permitting)',
    origin: 'Bandipora Bus Stand',
    destination: 'Dawar Gurez',
    busType: 'JKSRTC Snow Service',
    fare: '₹180',
  ),
  BusSchedule(
    route: 'Kishtwar to Marwah & Dachhan',
    departureTime: '07:00 AM (Alternate Days)',
    origin: 'Kishtwar Chowgan Stand',
    destination: 'Marwah Valley',
    busType: 'Rural Heavy Vehicle',
    fare: '₹160',
  ),
  BusSchedule(
    route: 'Doda to Bhaderwah Rural Feeder',
    departureTime: 'Hourly from 07:00 AM to 05:00 PM',
    origin: 'New Bus Stand Doda',
    destination: 'Kotli Bhaderwah',
    busType: 'Standard JKSRTC',
    fare: '₹60',
  ),
  BusSchedule(
    route: 'Poonch to Rajouri & Jammu Express',
    departureTime: '06:00 AM, 08:30 AM, 01:00 PM',
    origin: 'Poonch Bus Stand',
    destination: 'Jammu Bus Stand via Rajouri',
    busType: 'Deluxe Bus',
    fare: '₹380',
  ),
  BusSchedule(
    route: 'Srinagar to Uri Border Rural Service',
    departureTime: '07:30 AM & 02:00 PM',
    origin: 'Batmaloo / Parimpora Stand',
    destination: 'Uri Main Market',
    busType: 'Rural Shuttle',
    fare: '₹120',
  ),
];

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _callHighwayControl(String phone) {
    ActionUtils.launchPhoneCall(context, phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            DualPartyEmblem(size: 30),
            SizedBox(width: 10),
            Text('Transport & Mountain Routes'),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.partyBlue,
          unselectedLabelColor: AppColors.mutedInk,
          indicatorColor: AppColors.saffron,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              icon: Icon(Icons.terrain_outlined),
              text: 'Pass & Highway Status',
            ),
            Tab(
              icon: Icon(Icons.directions_bus_outlined),
              text: 'JKSRTC Bus Timetable',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Mountain Passes & Highway Live Status
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              // Highway Banner
              NeoSurface(
                padding: const EdgeInsets.all(16),
                borderRadius: 20,
                color: const Color(0xFFE0F2F1),
                borderColor: const Color(0xFF00897B).withValues(alpha: 0.35),
                child: Row(
                  children: [
                    const NeoIcon(
                      Icons.traffic,
                      color: Color(0xFF00796B),
                      size: 44,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'NH-44 & Mountain Road Alerts',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF004D40),
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Real-time connectivity advisory for NH-44, Razdan, Sadhna, Sinthan, and Mughal roads.',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.mutedInk,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _callHighwayControl('0194-2450022'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00796B),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Traffic Control Room: 0194-2450022',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (final pass in mountainPassesList) ...[
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pass.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  pass.connects,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.mutedInk,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: pass.status.toLowerCase().contains('open')
                                  ? AppColors.greenLight
                                  : (pass.status.toLowerCase().contains(
                                          'closed',
                                        )
                                        ? const Color(0xFFFFEBEE)
                                        : const Color(0xFFFFF3E0)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              pass.status,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color:
                                    pass.status.toLowerCase().contains('open')
                                    ? AppColors.green
                                    : (pass.status.toLowerCase().contains(
                                            'closed',
                                          )
                                          ? Colors.red
                                          : AppColors.saffronDeep),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.height,
                                  size: 14,
                                  color: AppColors.partyBlue,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Altitude: ${pass.altitude}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.partyBlue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              pass.advisory,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.ink,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          NeoButton(
                            onPressed: () =>
                                _callHighwayControl(pass.controlRoomPhone),
                            icon: Icons.phone_in_talk,
                            label: 'Contact Local Control Room',
                            variant: NeoButtonVariant.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Tab 2: JKSRTC Bus Timetable
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 36),
            children: [
              for (final bus in jksrtcBusRoutes) ...[
                NeoCard(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              bus.route,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: AppColors.ink,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.greenLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              bus.fare,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 14,
                            color: AppColors.saffronDeep,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            bus.departureTime,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.saffronDeep,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F7FB),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.alt_route,
                              size: 16,
                              color: AppColors.partyBlue,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${bus.origin} ➔ ${bus.destination} (${bus.busType})',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.ink,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
