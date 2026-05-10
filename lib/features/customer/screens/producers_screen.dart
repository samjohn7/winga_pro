import 'package:flutter/material.dart';

class ProducersScreen extends StatefulWidget {
  const ProducersScreen({super.key});

  @override
  State<ProducersScreen> createState() => _ProducersScreenState();
}

class _ProducersScreenState extends State<ProducersScreen> {

  // ── BRAND COLORS ─────────────────────────────────────────────
  static const Color primaryBlue = Color(0xFF1565C0);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color darkText = Color(0xFF0D1B2A);
  static const Color mutedText = Color(0xFF607D8B);
  static const Color background = Color(0xFFF4F6FA);

  final TextEditingController searchController =
      TextEditingController();

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> allPackages = [

    {
      'network': 'Tigo',
      'data': '5GB',
      'store': 'Juma Stores',
      'price': 'Tsh 3,500',
      'duration': '30 days',
      'rating': 4.8,
    },

    {
      'network': 'Vodacom',
      'data': '2GB',
      'store': 'Dar Data Hub',
      'price': 'Tsh 2,000',
      'duration': '7 days',
      'rating': 4.5,
    },

    {
      'network': 'Airtel',
      'data': '10GB',
      'store': 'Net King TZ',
      'price': 'Tsh 6,000',
      'duration': '30 days',
      'rating': 4.9,
    },

    {
      'network': 'Halotel',
      'data': '1GB',
      'store': 'Speed Zone',
      'price': 'Tsh 1,000',
      'duration': '3 days',
      'rating': 4.3,
    },
  ];

  List<Map<String, dynamic>> get filteredPackages {

    List<Map<String, dynamic>> results = allPackages;

    // FILTER NETWORK
    if (selectedFilter != 'All') {
      results = results.where((pkg) {
        return pkg['network'] == selectedFilter;
      }).toList();
    }

    // SEARCH
    if (searchController.text.isNotEmpty) {

      final query =
          searchController.text.toLowerCase();

      results = results.where((pkg) {

        final network =
            pkg['network'].toString().toLowerCase();

        final data =
            pkg['data'].toString().toLowerCase();

        final store =
            pkg['store'].toString().toLowerCase();

        return network.contains(query) ||
            data.contains(query) ||
            store.contains(query);

      }).toList();
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: primaryBlue,

      body: SafeArea(

        child: Column(

          children: [

            // ── HEADER ─────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    'Browse Packages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Find internet bundles from producers',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ── SEARCH BAR ─────────────────
                  Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(14),
                    ),

                    child: TextField(

                      controller: searchController,

                      onChanged: (value) {
                        setState(() {});
                      },

                      decoration: InputDecoration(
                        hintText:
                            'Search by network or GB...',
                        hintStyle: const TextStyle(
                          color: mutedText,
                        ),

                        prefixIcon: const Icon(
                          Icons.search,
                          color: primaryBlue,
                        ),

                        border: InputBorder.none,

                        contentPadding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── FILTER CHIPS ───────────────
                  SingleChildScrollView(

                    scrollDirection: Axis.horizontal,

                    child: Row(

                      children: [

                        'All',
                        'Tigo',
                        'Vodacom',
                        'Airtel',
                        'Halotel',

                      ].map((filter) {

                        final isSelected =
                            selectedFilter == filter;

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            right: 8,
                          ),

                          child: ChoiceChip(

                            label: Text(filter),

                            selected: isSelected,

                            onSelected: (selected) {

                              setState(() {
                                selectedFilter = filter;
                              });
                            },

                            backgroundColor:
                                Colors.white.withOpacity(0.15),

                            selectedColor: Colors.white,

                            labelStyle: TextStyle(

                              color: isSelected
                                  ? primaryBlue
                                  : Colors.white,

                              fontWeight:
                                  FontWeight.w600,
                            ),

                            side: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                            ),

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                          ),
                        );

                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // ── PACKAGE LIST ─────────────────────
            Expanded(

              child: Container(

                decoration: const BoxDecoration(

                  color: background,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),

                child: filteredPackages.isEmpty

                    // ── EMPTY STATE ─────────────
                    ? const Center(
                        child: Text(
                          'No packages found',
                          style: TextStyle(
                            color: mutedText,
                            fontSize: 15,
                          ),
                        ),
                      )

                    // ── LIST ────────────────────
                    : ListView.separated(

                        padding: const EdgeInsets.all(16),

                        itemCount:
                            filteredPackages.length,

                        separatorBuilder:
                            (context, index) =>
                                const SizedBox(height: 12),

                        itemBuilder: (context, index) {

                          return _buildPackageCard(
                            filteredPackages[index],
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── PACKAGE CARD ─────────────────────────────────────────────
  Widget _buildPackageCard(
      Map<String, dynamic> package,
      ) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(

        children: [

          // ── ICON ─────────────────────────────
          Container(

            width: 52,
            height: 52,

            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: const Icon(
              Icons.wifi,
              color: primaryBlue,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          // ── INFO ─────────────────────────────
          Expanded(

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  '${package['network']} - ${package['data']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  package['store'],
                  style: const TextStyle(
                    fontSize: 13,
                    color: mutedText,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [

                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 17,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      package['rating'].toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: mutedText,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      package['duration'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: mutedText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ── PRICE + BUTTON ──────────────────
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            children: [

              Text(
                package['price'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryBlue,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(

                height: 34,

                child: ElevatedButton(

                  onPressed: () {},

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),

                  child: const Text(
                    'Buy',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}