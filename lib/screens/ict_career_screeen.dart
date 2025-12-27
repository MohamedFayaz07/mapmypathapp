import 'package:flutter/material.dart';
import 'package:mapmypathapp/screens/frontend_screen.dart';

class ICTCareersScreen extends StatelessWidget {
  ICTCareersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Careers in ICT"),
        backgroundColor: Colors.green,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: _ictCareers.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final career = _ictCareers[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (career["title"] == "Frontend") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FrontendRoadmapScreen(),
                      ),
                    );
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      career['image']!,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      career['title']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // List of ICT careers
  final List<Map<String, String>> _ictCareers = [
    {'title': 'Frontend', 'image': 'assets/frontend.png'},
    {'title': 'Backend', 'image': 'assets/backend.png'},
    {'title': 'DevOps', 'image': 'assets/devops.png'},
    {'title': 'AI Engineer', 'image': 'assets/ai_engineer.png'},
    {'title': 'UI / UX', 'image': 'assets/ui_ux.png'},
    {'title': 'Data Analyst', 'image': 'assets/data_analyst.png'},
    {'title': 'Cyber Security', 'image': 'assets/cyber_security.png'},
    {'title': 'Full Stack', 'image': 'assets/full_stack.png'},
  ];
}

// Optional: Detail Screen for each career
class CareerDetailScreen extends StatelessWidget {
  final Map<String, String> career;

  const CareerDetailScreen({super.key, required this.career});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(career['title']!),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(career['image']!, height: 100),
            const SizedBox(height: 20),
            Text(
              '${career['title']} Career Path',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Detailed information about this career will go here.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
