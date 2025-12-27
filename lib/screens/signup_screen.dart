import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String? _passwordError;

  // Email validation
  bool _isValidEmail(String value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(value.trim());
  }

  // Show Toast
  void _showToast(String msg, {Color backgroundColor = Colors.red}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Validate form
  bool _validateForm() {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _passwordError = null;
    });

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showToast("All fields are required.");
      return false;
    }

    if (!_isValidEmail(email)) {
      _showToast("Please enter a valid email.");
      return false;
    }

    if (password.length < 6) {
      _showToast("Password must be at least 6 characters.");
      return false;
    }

    if (password != confirmPassword) {
      setState(() {
        _passwordError = "Passwords do not match.";
      });
      _showToast("Passwords do not match.");
      return false;
    }

    return true;
  }

  // Sign Up action
  void _signUp() async {
    if (_validateForm()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final username = _usernameController.text.trim();

      try {
        // Create user in Firebase Authentication
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        // Show success message
        _showToast(
          "Account created successfully!",
          backgroundColor: Colors.green,
        );

        // Navigate to the next screen after a delay
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              '/role',
              arguments: username,
            );
          }
        });
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';

        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            errorMessage = 'The account already exists for that email.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again.';
        }

        // Show error toast
        _showToast(errorMessage);
      } catch (e) {
        // Handle unexpected errors
        _showToast('An unexpected error occurred: $e');
      }
    }
  }

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

              // Tabs: Login | Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Username
              CustomInputField(
                icon: Icons.person,
                hintText: "Username",
                controller: _usernameController,
              ),

              const SizedBox(height: 16),

              // Email
              CustomInputField(
                icon: Icons.email,
                hintText: "Email",
                controller: _emailController,
              ),

              const SizedBox(height: 16),

              // Password
              CustomInputField(
                icon: Icons.vpn_key,
                hintText: "Password",
                isPassword: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 16),

              // Confirm Password
              CustomInputField(
                icon: Icons.vpn_key,
                hintText: "Confirm Password",
                isPassword: true,
                controller: _confirmPasswordController,
              ),

              // Password Match Error
              if (_passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _passwordError!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Sign Up Button
              SizedBox(
                width: screenWidth * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF46C364),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text("- Sign up with -"),

              const SizedBox(height: 12),

              // Social Buttons
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

              // Already have an account?
              RichText(
                text: TextSpan(
                  text: "Already have an Account? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: const TextStyle(color: Colors.orange),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

// 🔁 Custom Input Field with Password Toggle
class CustomInputField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomInputField({
    super.key,
    required this.icon,
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
                : null,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// 🔁 Social Icon
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
