import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  int selectedCategory = 0;

  final List<String> categories = [
    "All",
    "Vodacom",
    "Airtel",
    "Tigo",
    "Halotel",
  ];

  final List<Map<String, dynamic>> packages = [
    {
      "title": "1GB Daily Bundle",
      "price": "TZS 1,000",
      "provider": "Vodacom",
      "rating": 4.5,
    },
    {
      "title": "5GB Weekly Bundle",
      "price": "TZS 4,500",
      "provider": "Airtel",
      "rating": 4.2,
    },
    {
      "title": "10GB Monthly Bundle",
      "price": "TZS 8,000",
      "provider": "Tigo",
      "rating": 4.8,
    },
  ];

  List<Map<String, dynamic>> get filteredPackages {
    if (selectedCategory == 0) return packages;

    return packages
        .where((p) => p["provider"] == categories[selectedCategory])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: AppBar(
        title: const Text("Winga Pro Market"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔍 SEARCH BAR
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search packages...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 📡 CATEGORIES
              const Text(
                "Categories",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    final isSelected = selectedCategory == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // ⭐ FEATURED HEADER
              const Text(
                "Available Packages",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // 📦 PACKAGES LIST
              ListView.builder(
                itemCount: filteredPackages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) {
                  final package = filteredPackages[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        // LEFT SIDE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package["title"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(package["provider"]),

                            const SizedBox(height: 5),

                            Text(
                              package["price"],
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        // RIGHT SIDE (BUTTON)
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Selected ${package["title"]}",
                                ),
                              ),
                            );
                          },
                          child: const Text("Buy"),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 🏢 PRODUCER PREVIEW SECTION
              const Text(
                "Top Producers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 120,

                child: ListView(
                  scrollDirection: Axis.horizontal,

                  children: [
                    producerCard("Vodacom Store", 4.8),
                    producerCard("Airtel Hub", 4.5),
                    producerCard("Tigo Shop", 4.2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget producerCard(String name, double rating) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.store, color: Colors.blue, size: 30),

          const SizedBox(height: 10),

          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 5),

          Text("⭐ $rating"),
        ],
      ),
    );
  }
}