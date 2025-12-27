import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String? username;

  const DashboardScreen({super.key, this.username});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredTrendingCareers = [];
  bool isSearching = false;

  // List of trending careers
  List<Map<String, dynamic>> get trendingCareers => [
    {
      "title": "Artificial Intelligence",
      "subtitle": "Current Search Results : 24850🔥🔥",
      "image": "assets/ai.png",
      "onTap": () {
        // Navigate to AI screen
      },
    },
    {
      "title": "Machine Learning",
      "subtitle": "Current Search Results : 18900🔥",
      "image": "assets/ml.png",
      "onTap": () {
        // Navigate to ML screen
      },
    },
    {
      "title": "Data Science",
      "subtitle": "Current Search Results : 15200🔥",
      "image": "assets/ds.png",
      "onTap": () {
        // Navigate to DS screen
      },
    },
    {
      "title": "Frontend",
      "subtitle": "Current Search Results : 12500🔥",
      "image": "assets/frontend.png",
      "onTap": () {
        Navigator.pushNamed(context, '/frontend');
      },
    },
    {
      "title": "Cybersecurity",
      "subtitle": "Current Search Results : 9800🔥",
      "image": "assets/ai.png",
      "onTap": () {
        // Navigate to Cybersecurity screen
      },
    },
    {
      "title": "Cloud Computing",
      "subtitle": "Current Search Results : 8700🔥",
      "image": "assets/ml.png",
      "onTap": () {
        // Navigate to Cloud Computing screen
      },
    },
  ];

  @override
  void initState() {
    super.initState();
    filteredTrendingCareers = List.from(trendingCareers);
    _searchController.addListener(_filterTrendingCareers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterTrendingCareers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredTrendingCareers = List.from(trendingCareers);
        isSearching = false;
      } else {
        filteredTrendingCareers =
            trendingCareers
                .where(
                  (career) => career["title"].toLowerCase().contains(query),
                )
                .toList();
        isSearching = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30, // Increased padding for bottom navigation bar
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Row(
                children: [
                  Text(
                    "Hello ${widget.username ?? 'User'}! 👋", // Dynamically display the username
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 190),
                  Align(
                    alignment: Alignment.topRight,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search your career",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      isSearching
                          ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                          : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),

              // Search results indicator
              if (isSearching)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Found ${filteredTrendingCareers.length} result${filteredTrendingCareers.length != 1 ? 's' : ''}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),

              const SizedBox(height: 24),

              // Dashboard Section
              const Text(
                "Dashboard",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildDashboardCard(context),

              const SizedBox(height: 24),

              // Scheduled Works
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Scheduled Works",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("May 2025 ▾", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 10),
              _buildDateRow(),

              const SizedBox(height: 24),

              // Top Trending Careers
              const Text(
                "Top Trending Careers 🔥",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 150, // Card height
                child:
                    filteredTrendingCareers.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 48,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                isSearching
                                    ? "No careers found"
                                    : "No trending careers available",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              if (isSearching) ...[
                                const SizedBox(height: 4),
                                Text(
                                  "Try a different search term",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filteredTrendingCareers.length,
                          itemBuilder: (context, index) {
                            final career = filteredTrendingCareers[index];
                            return _buildTrendingCard(
                              context,
                              career["title"],
                              career["subtitle"],
                              career["image"],
                              career["onTap"],
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, '/ai'); // Navigate to AI screen
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset('assets/ai.png', height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Artificial Intelligence",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text(
                    "Up Next : Multimodal AI Usecases",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   '/ai',
                      // ); // Navigate to AI screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Continue →"),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Example circular progress
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 0.65,
                    color: Colors.green,
                    backgroundColor: Colors.grey.shade200,
                    strokeWidth: 5,
                  ),
                  const Center(child: Text("65%")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _DateItem(day: "Sat", date: "17"),
        _DateItem(day: "Sun", date: "18"),
        _DateItem(day: "Mon", date: "19"),
        _DateItem(day: "Tue", date: "20"),
        _DateItem(day: "Wed", date: "21"),
      ],
    );
  }

  Widget _buildTrendingCard(
    BuildContext context,
    String title,
    String subtitle,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(imagePath, height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Try Now →"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateItem extends StatelessWidget {
  final String day;
  final String date;

  const _DateItem({required this.day, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(date, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
