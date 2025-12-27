import 'package:flutter/material.dart';
import 'package:mapmypathapp/screens/ict_career_screeen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredCategories = [];
  bool isSearching = false;

  // List of categories (dynamic)
  final List<Map<String, String>> categories = [
    {"title": "Information Technology", "image": "assets/ict.png"},
    {"title": "Engineering", "image": "assets/engineering.png"},
    {"title": "Healthcare", "image": "assets/health.png"},
    {"title": "Arts & Design", "image": "assets/arts.png"},
    {"title": "Law & Legal", "image": "assets/law.png"},
    {"title": "Business Management", "image": "assets/management.png"},
    {"title": "Finance & Banking", "image": "assets/finance.png"},
    {"title": "Media & Communication", "image": "assets/media.png"},
    {"title": "Education", "image": "assets/education.jpeg"},
    {"title": "Science & Research", "image": "assets/science.jpeg"},
  ];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories);
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCategories = List.from(categories);
        isSearching = false;
      } else {
        filteredCategories =
            categories
                .where(
                  (category) =>
                      category["title"]!.toLowerCase().contains(query),
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
          bottom: 30, // Padding for bottom navigation bar
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Explore",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Search bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search your category",
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
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                  ),
                ],
              ),
            ),

            // Search results indicator
            if (isSearching)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Found ${filteredCategories.length} result${filteredCategories.length != 1 ? 's' : ''}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),

            const SizedBox(height: 20),

            // Grid view
            Expanded(
              child:
                  filteredCategories.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isSearching
                                  ? "No categories found"
                                  : "No categories available",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (isSearching) ...[
                              const SizedBox(height: 8),
                              Text(
                                "Try a different search term",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ],
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          itemCount: filteredCategories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 items per row
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1,
                              ),
                          itemBuilder: (context, index) {
                            final category = filteredCategories[index];
                            return GestureDetector(
                              onTap: () {
                                if (category["title"] ==
                                    "Information Technology") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ICTCareersScreen(),
                                    ),
                                  );
                                } else {
                                  // Handle other categories
                                  // Navigator.pushNamed(
                                  // context,
                                  // '/${category["title"]}',
                                  //);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      category["image"]!,
                                      height: 60,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      category["title"]!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_right_alt,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                              ),
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
}
