import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // ── Brand Colors ──────────────────────────────────────────────
  static const Color primary = Colors.blue;
  
  static const Color background = Color(0xFFF4F6FA);
  static const Color cardBg = Colors.white;

  static const Color textDark = Color(0xFF0D1B2A);
  static const Color textMuted = Color(0xFF607D8B);

  static const Color blueBadgeBg = Color(0xFFE3F2FD);
  static const Color blueBadgeTxt = Color(0xFF1565C0);

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> allPackages = [
    {
      'name': 'Tigo – 5GB',
      'seller': 'Juma Stores',
      'price': 'Tsh 3,500',
      'validity': '30 days',
      'rating': '4.8',
      'iconColor': const Color(0xFF1565C0),
      'iconBg': const Color(0xFFE3F2FD),
    },
    {
      'name': 'Vodacom – 2GB',
      'seller': 'Dar Data Hub',
      'price': 'Tsh 2,000',
      'validity': '7 days',
      'rating': '4.5',
      'iconColor': const Color(0xFF1E88E5),
      'iconBg': const Color(0xFFBBDEFB),
    },
    {
      'name': 'Airtel – 10GB',
      'seller': 'Net King TZ',
      'price': 'Tsh 6,000',
      'validity': '30 days',
      'rating': '4.9',
      'iconColor': const Color(0xFF42A5F5),
      'iconBg': const Color(0xFFD0E8FF),
    },
  ];

  String searchText = "";

  List<Map<String, dynamic>> get filteredPackages {
    if (searchText.isEmpty) {
      return allPackages;
    }

    return allPackages.where((pkg) {

      final name =
          pkg['name'].toString().toLowerCase();

      final seller =
          pkg['seller'].toString().toLowerCase();

      return name.contains(searchText.toLowerCase()) ||
          seller.contains(searchText.toLowerCase());

    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              _buildHeader(),

              _buildWalletCard(),

              _buildSearchBar(),

              _buildSectionTitle(),

              _buildPackageList(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: const [

              Text(
                'Welcome back 👋',
                style: TextStyle(
                  color: textMuted,
                  fontSize: 13,
                ),
              ),

              SizedBox(height: 2),

              Text(
                'Amani Juma',
                style: TextStyle(
                  color: textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          Stack(
            children: [

              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius:
                      BorderRadius.circular(12),

                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),

                child: const Icon(
                  Icons.notifications_outlined,
                  color: primary,
                ),
              ),

              Positioned(
                top: 6,
                right: 6,

                child: Container(
                  width: 8,
                  height: 8,

                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Wallet Card ───────────────────────────────────────────────
  Widget _buildWalletCard() {
    return Container(
      margin:
          const EdgeInsets.fromLTRB(16, 0, 16, 16),

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            'Wallet Balance',
            style: TextStyle(
              color: Color(0xFFBBD6F5),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Tsh 12,500/=',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [

              Expanded(
                child:
                    _walletButton(Icons.add, 'Top Up'),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _walletButton(
                  Icons.history,
                  'Transactions',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _walletButton(
      IconData icon,
      String label,
      ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 11),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        children: [

          Icon(icon,
              color: Colors.white,
              size: 20),

          const SizedBox(height: 4),

          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFBBD6F5),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ── REAL SEARCH BAR ───────────────────────────────────────────
  Widget _buildSearchBar() {
    return Container(
      margin:
          const EdgeInsets.fromLTRB(16, 0, 16, 16),

      padding:
          const EdgeInsets.symmetric(horizontal: 14),

      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: TextField(
        controller: searchController,

        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },

        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: primary),
          hintText: 'Search packages...',
        ),
      ),
    );
  }

  // ── Section Title ─────────────────────────────────────────────
  Widget _buildSectionTitle() {
    return const Padding(
      padding:
          EdgeInsets.fromLTRB(16, 0, 16, 12),

      child: Text(
        'Popular Packages',
        style: TextStyle(
          color: textDark,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ── Package List ──────────────────────────────────────────────
  Widget _buildPackageList() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16),

      child: Column(
        children: filteredPackages
            .map(
              (pkg) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 10),

                child: _buildPackageCard(pkg),
              ),
            )
            .toList(),
      ),
    );
  }

  // ── Package Card ──────────────────────────────────────────────
  Widget _buildPackageCard(
      Map<String, dynamic> pkg,
      ) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: Colors.grey.shade100,
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 46,
            height: 46,

            decoration: BoxDecoration(
              color: pkg['iconBg'],
              borderRadius:
                  BorderRadius.circular(13),
            ),

            child: Icon(
              Icons.wifi,
              color: pkg['iconColor'],
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  pkg['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  pkg['seller'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: textMuted,
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),

                  decoration: BoxDecoration(
                    color: blueBadgeBg,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: Text(
                    '⭐ ${pkg['rating']}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: blueBadgeTxt,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,

            children: [

              Text(
                pkg['price'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                pkg['validity'],
                style: const TextStyle(
                  fontSize: 11,
                  color: textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}