// frontend_screen.dart
import 'package:flutter/material.dart';

class FrontendRoadmapScreen extends StatefulWidget {
  const FrontendRoadmapScreen({super.key});

  @override
  State<FrontendRoadmapScreen> createState() => _FrontendRoadmapScreenState();
}

class _FrontendRoadmapScreenState extends State<FrontendRoadmapScreen> {
  int? selectedMilestoneIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MediaQuery.of(context).size.width < 400
              ? "Frontend Roadmap"
              : "Frontend Developer Roadmap",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade100,
              Colors.blue.shade50,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            MediaQuery.of(context).size.width < 400 ? 12 : 16,
          ),
          child: Column(
            children: [
              // Header section
              _buildHeader(),
              SizedBox(
                height: MediaQuery.of(context).size.width < 400 ? 16 : 24,
              ),
              // Roadmap steps
              ..._milestones.asMap().entries.map((entry) {
                final index = entry.key;
                final milestone = entry.value;
                return _buildMilestoneCard(index, milestone);
              }).toList(),
              SizedBox(
                height: MediaQuery.of(context).size.width < 400 ? 60 : 100,
              ), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.code,
                  color: Colors.white,
                  size: isSmallScreen ? 20 : 24,
                ),
              ),
              SizedBox(width: isSmallScreen ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Frontend Development",
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "Master the art of building beautiful web interfaces",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: isSmallScreen ? 10 : 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          // Stats row – equal width and responsive text to avoid overflow on small screens
          Builder(
            builder: (context) {
              final verySmall = screenWidth < 340;
              if (verySmall) {
                // Stack into two rows on extremely small screens
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            "Steps",
                            "${_milestones.length}",
                            isSmallScreen,
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Expanded(
                          child: _buildStatItem(
                            "Duration",
                            "6-12 months",
                            isSmallScreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 8 : 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            "Level",
                            "Beginner to Advanced",
                            isSmallScreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      "Steps",
                      "${_milestones.length}",
                      isSmallScreen,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 12),
                  Expanded(
                    child: _buildStatItem(
                      "Duration",
                      "6-12 months",
                      isSmallScreen,
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 8 : 12),
                  Expanded(
                    child: _buildStatItem(
                      "Level",
                      "Beginner to Advanced",
                      isSmallScreen,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, bool isSmallScreen) {
    final bool isLongValue = value.length > 14; // e.g., "Beginner to Advanced"
    final double valueFont = isSmallScreen ? 13 : 18;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isLongValue
            ? Text(
              value,
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: valueFont,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                height: 1.1,
              ),
            )
            : FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: valueFont,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 10 : 12,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMilestoneCard(int index, Map<String, dynamic> milestone) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    final originalTitle = milestone['title'] as String;
    final title = isSmallScreen ? _getShortTitle(originalTitle) : originalTitle;
    final colorIndex = milestone['color'] as int;
    final color = getMilestoneColor(colorIndex);
    final isSelected = selectedMilestoneIndex == index;
    final content = milestone['content'] as String;

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Column(
        children: [
          // Main milestone card
          GestureDetector(
            onTap: () {
              setState(() {
                selectedMilestoneIndex =
                    selectedMilestoneIndex == index ? null : index;
              });
            },
            child: Container(
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: isSelected ? Border.all(color: color, width: 2) : null,
              ),
              child: Row(
                children: [
                  // Step number
                  Container(
                    width: isSmallScreen ? 32 : 40,
                    height: isSmallScreen ? 32 : 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 12 : 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  // Title and description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: isSmallScreen ? 2 : 4),
                        Text(
                          milestone['description'] ?? 'Click to learn more',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isSmallScreen ? 10 : 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  // Expand/collapse icon
                  Icon(
                    isSelected ? Icons.expand_less : Icons.expand_more,
                    color: color,
                    size: isSmallScreen ? 20 : 24,
                  ),
                ],
              ),
            ),
          ),
          // Expanded content
          if (isSelected)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(top: isSmallScreen ? 6 : 8),
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 11 : 14,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Navigate to detailed lesson
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Starting lesson: $title'),
                                backgroundColor: color,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            size: isSmallScreen ? 16 : 20,
                          ),
                          label: Text(
                            isSmallScreen ? 'Start' : 'Start Learning',
                            style: TextStyle(fontSize: isSmallScreen ? 10 : 14),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 8 : 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 8 : 12),
                      IconButton(
                        onPressed: () {
                          // TODO: Bookmark functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to bookmarks'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.bookmark_border,
                          size: isSmallScreen ? 20 : 24,
                        ),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static const List<Map<String, dynamic>> _milestones = [
    {
      'title': 'Web Development Basics',
      'color': 0,
      'description': 'Learn HTML, CSS, and JavaScript fundamentals',
      'content':
          'Start your journey with the building blocks of web development. Learn HTML for structure, CSS for styling, and JavaScript for interactivity. This foundation is crucial for all frontend development.',
    },
    {
      'title': 'Version Control',
      'color': 1,
      'description': 'Master Git and GitHub for collaboration',
      'content':
          'Learn Git version control system to track changes, collaborate with other developers, and manage your codebase effectively. GitHub will be your portfolio and collaboration platform.',
    },
    {
      'title': 'Advanced JavaScript',
      'color': 2,
      'description': 'Deep dive into modern JavaScript features',
      'content':
          'Master ES6+ features, async programming, DOM manipulation, and modern JavaScript patterns. This is essential for building dynamic and interactive web applications.',
    },
    {
      'title': 'Package Managers',
      'color': 2,
      'description': 'Use npm, yarn, and manage dependencies',
      'content':
          'Learn to use package managers like npm and yarn to install, manage, and update third-party libraries and tools that will speed up your development process.',
    },
    {
      'title': 'Styling',
      'color': 2,
      'description': 'Master CSS frameworks and preprocessors',
      'content':
          'Explore CSS frameworks like Bootstrap, Tailwind CSS, and preprocessors like Sass. Learn responsive design principles and create beautiful, modern user interfaces.',
    },
    {
      'title': 'Build Tools',
      'color': 2,
      'description': 'Webpack, Vite, and modern build processes',
      'content':
          'Understand build tools and bundlers like Webpack, Vite, and Parcel. Learn to optimize your applications for production and improve development workflow.',
    },
    {
      'title': 'APIs & HTTP',
      'color': 2,
      'description': 'Connect to backend services and APIs',
      'content':
          'Learn to make HTTP requests, work with REST APIs, handle JSON data, and integrate with backend services. Understand authentication and data fetching patterns.',
    },
    {
      'title': 'Testing',
      'color': 2,
      'description': 'Write tests for your frontend code',
      'content':
          'Master testing frameworks like Jest, React Testing Library, or Cypress. Learn to write unit tests, integration tests, and end-to-end tests for reliable applications.',
    },
    {
      'title': 'Performance Optimization',
      'color': 2,
      'description': 'Optimize your applications for speed',
      'content':
          'Learn techniques to improve loading times, reduce bundle sizes, optimize images, and implement lazy loading. Performance is crucial for user experience.',
    },
    {
      'title': 'Soft Skills',
      'color': 2,
      'description': 'Communication, teamwork, and problem-solving',
      'content':
          'Develop essential soft skills like effective communication, collaboration, problem-solving, and time management. These skills are as important as technical abilities.',
    },
    {
      'title': 'You\'re a Frontend Developer!',
      'color': 2,
      'description': 'Congratulations on completing the roadmap!',
      'content':
          'You\'ve successfully completed the frontend development roadmap! You now have the skills to build modern, responsive web applications. Continue learning and stay updated with the latest technologies.',
    },
  ];

  static Color getMilestoneColor(int index) {
    switch (index) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getShortTitle(String originalTitle) {
    switch (originalTitle) {
      case 'Web Development Basics':
        return 'Web Basics';
      case 'Version Control':
        return 'Git & GitHub';
      case 'Advanced JavaScript':
        return 'JS Advanced';
      case 'Package Managers':
        return 'NPM & Yarn';
      case 'Styling':
        return 'CSS & Frameworks';
      case 'Build Tools':
        return 'Webpack & Vite';
      case 'APIs & HTTP':
        return 'APIs & HTTP';
      case 'Testing':
        return 'Testing';
      case 'Performance Optimization':
        return 'Performance';
      case 'Soft Skills':
        return 'Soft Skills';
      case 'You\'re a Frontend Developer!':
        return 'Congratulations!';
      default:
        return originalTitle;
    }
  }
}
