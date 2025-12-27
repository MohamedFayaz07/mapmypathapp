import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String password = '';
  String email = '';
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Logo
              Image.asset('assets/MapMyPathLogo.png', height: 80),

              const SizedBox(height: 16),

              // App Name
              const Text(
                "MapMyPath",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263238),
                ),
              ),

              const SizedBox(height: 24),

              // Login | Sign Up tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Email field
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Password
              TextField(
                obscureText: !_isPasswordVisible, // Hide text when not visible
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons
                              .visibility // Show eye open
                          : Icons.visibility_off, // Show eye closed
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // Toggle the password visibility
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: screenWidth * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      Fluttertoast.showToast(
                        msg: "Login Successfull!",
                        backgroundColor: const Color(0xFF46C364),
                      );

                      if (mounted) {
                        Navigator.pushReplacementNamed(context, '/role');
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = '';

                      switch (e.code) {
                        case 'user-not-found':
                          errorMessage = 'No user found for that email.';
                          break;
                        case 'wrong-password':
                          errorMessage =
                              'Wrong password provided for that user.';
                          break;
                        case 'invalid-email':
                          errorMessage = 'The email address is not valid.';
                          break;
                        case 'user-disabled':
                          errorMessage = 'This account has been disabled.';
                          break;
                        case 'too-many-requests':
                          errorMessage = 'Too many attempts. Try again later.';
                          break;
                        case 'operation-not-allowed':
                          errorMessage = 'Sign-in method not enabled.';
                          break;
                        default:
                          errorMessage = 'An error occurred. Please try again.';
                      }

                      // Show Toast
                      Fluttertoast.showToast(
                        msg: errorMessage,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF46C364),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text("- Sign in with -"),

              const SizedBox(height: 12),

              // Social buttons with PNGs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SocialIcon(imagePath: 'assets/icons/googleblack.png'),
                  SizedBox(width: 20),
                  SocialIcon(imagePath: 'assets/icons/Facebook.png'),
                  SizedBox(width: 20),
                  SocialIcon(imagePath: 'assets/icons/apple.png'),
                ],
              ),

              const SizedBox(height: 30),

              RichText(
                text: TextSpan(
                  text: "Don't Have an Account? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          "Register",
                          style: const TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable social button widget using PNG images
class SocialIcon extends StatelessWidget {
  final String imagePath;
  const SocialIcon({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
