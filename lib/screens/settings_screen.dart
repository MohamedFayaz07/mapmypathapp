import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Simulated user data
  final String _username = "Mohamed Fayaz";
  final String _handle = "@fayaz22";
  final int _currentPoints = 295;
  final int _totalPoints = 500;
  final String _currentLevel = "Gold";

  // Function to handle logout
  void _logout() async {
    try {
      await _auth.signOut();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error logging out: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30), // Space for bottom nav
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Profile Section
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(_handle, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Current Level : "),
                    Text(
                      _currentLevel,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: _currentPoints / _totalPoints,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
                const SizedBox(height: 8),
                Text("$_currentPoints / $_totalPoints Points"),
              ],
            ),

            const SizedBox(height: 32),

            // Settings Options
            _buildSettingsItem(Icons.edit, "Edit Profile", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Edit Profile not implemented yet."),
                ),
              );
            }),
            _buildSettingsItem(Icons.notifications, "Notifications", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Notifications not implemented yet."),
                ),
              );
            }),
            _buildSettingsItem(Icons.lock, "Privacy & Policy", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Privacy & Policy not implemented yet."),
                ),
              );
            }),
            _buildSettingsItem(Icons.phone, "Contact Us", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Contact Us not implemented yet."),
                ),
              );
            }),
            _buildSettingsItem(Icons.help, "FAQ", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("FAQ not implemented yet.")),
              );
            }),

            const SizedBox(height: 24),

            // Logout Button
            SizedBox(
              width: screenWidth * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("LOGOUT"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build settings item
  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
