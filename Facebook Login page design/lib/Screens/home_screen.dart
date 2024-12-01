import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Allows scrolling when keyboard is shown
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              // Facebook title
              _buildHeader(),
              const SizedBox(height: 15),
              // Login container with input fields and button
              _buildLoginContainer(),
            ],
          ),
        ),
      ),
    );
  }

  // Header displaying the Facebook title
  Widget _buildHeader() {
    return Text(
      'f a c e b o o k',
      style: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.w900,
        color: Colors.blue.shade800,
      ),
    );
  }

  // Login container with text fields and button
  Widget _buildLoginContainer() {
    return Container(
      width: double.infinity, // Full width, but constrained to maxWidth of 450
      constraints: const BoxConstraints(maxWidth: 450),
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Log in to Facebook',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          // Email/Phone input field
          _buildInputField(hint: 'Enter address or phone number'),
          // Password input field with hidden text
          _buildInputField(hint: 'Password', obsText: true),
          // Login button
          _buildLoginButton(),
          // Additional options (forgot account and sign-up)
          _buildAdditionalOptions(),
        ],
      ),
    );
  }

  // Method to build input text fields
  Widget _buildInputField({
    required String hint,
    bool obsText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextField(
        obscureText: obsText, // Obscure password text
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade600),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(width: 0.5, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(width: 1.25, color: Colors.black),
          ),
        ),
      ),
    );
  }

  // Login button styled as an ElevatedButton
  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            overlayColor: Colors.white.withOpacity(0.2),
            backgroundColor: Colors.blue.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Log In',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Additional options for forgotten account and sign-up
  Widget _buildAdditionalOptions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Forgotten account button
        _buildTextButton('Forgotten account?', () {}),
        Text(
          ' or ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.blue.shade800,
          ),
        ),
        // Sign-up button
        _buildTextButton('Sign up for Facebook', () {}),
      ],
    );
  }

  // Helper method to create TextButton with specified text and action
  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w200,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }
}
