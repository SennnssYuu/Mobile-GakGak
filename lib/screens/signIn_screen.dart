import 'package:flutter/material.dart';

import 'package:mobile_gakgak/screens/signUp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(36, 36, 36, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                // Back button
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'By logging in, you agree to our Terms of Use.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 32),

                // Email label
                const Tlabel(
                  label: 'Email',
                ),

                const SizedBox(height: 8),

                // Email input
                const TFlabel(
                  hint: 'Your Email',
                ),

                const SizedBox(height: 8),

                // Password label
                const Tlabel(
                  label: 'Password',
                ),

                const SizedBox(height: 8),

                // Password input
                const TFlabel(
                  hint: 'Your password',
                ),

                const SizedBox(height: 12),

                const Text(
                  'We will send you an e-mail with a confirmation link.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 24),

                // Connect button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Connect',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(36, 36, 36, 1),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Or divider
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Or', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Email button
                SocialButton(
                  icon: Icons.email,
                  text: 'Don\'t have an account yet?',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      )
                    );
                  },
                ),

                const SizedBox(height: 12),

                // Facebook button
                SocialButton(
                  icon: Icons.facebook,
                  text: 'Sign in with Facebook',
                  onPressed: () {},
                ),

                const SizedBox(height: 12),
                
                // Google button
                SocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Sign in with Google',
                  onPressed: () {},
                ),

                const SizedBox(height: 32),

                // Privacy policy
                const Center(
                  child: Text(
                    'For more information, please see our Privacy policy.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TFlabel extends StatelessWidget {

  final String hint;
  const TFlabel({
    super.key,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class Tlabel extends StatelessWidget {

  final String label;
  const Tlabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        icon: Icon(icon, size: 24, color: Color.fromRGBO(36, 36, 36, 1)),
        label: Text(text, style: TextStyle(color: Color.fromRGBO(36, 36, 36, 1))),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
