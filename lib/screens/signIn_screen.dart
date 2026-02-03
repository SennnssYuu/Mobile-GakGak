import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:mobile_gakgak/screens/home_screen.dart';
import 'package:mobile_gakgak/screens/signUp_screen.dart';
import 'package:mobile_gakgak/screens/forgotPassword_screen.dart';
import 'package:mobile_gakgak/widget/appBackground.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackground(),
          SafeArea(
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
        
                  const SizedBox(height: 32),
        
                  // Email label
                  const Textlabel(
                    label: 'Email',
                  ),
        
                  const SizedBox(height: 8),
        
                  // Email input
                  const TextFieldNormal(
                    hint: 'Your Email',
                  ),
        
                  const SizedBox(height: 8),
        
                  // Password label
                  const Textlabel(
                    label: 'Password',
                  ),
        
                  const SizedBox(height: 8),
        
                  // Password input
                  const TFPassword(
                    hint: 'Your password',
                  ),
        
                  const SizedBox(height: 12),
        
                  RichText(
                    text: TextSpan(
                      text: 'If you forgot your password, click ',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForPasScreen(),
                                )
                              );
                            },
                        ),
                        const TextSpan(
                          text: '.',
                        ),
                      ],
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
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        )
                      );
                      },
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
                          builder: (context) => const SignupScreen(),
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
        ]
      ),
    );
  }
}

class TextFieldNormal extends StatelessWidget {

  final String hint;
  const TextFieldNormal({
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

class Textlabel extends StatelessWidget {

  final String label;
  const Textlabel({
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

class TFPassword extends StatefulWidget {
  final String hint;

  const TFPassword({
    super.key,
    required this.hint,
  });

  @override
  State<TFPassword> createState() => _TFPasswordState();
}

class _TFPasswordState extends State<TFPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      obscuringCharacter: '●', // big filled circle
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
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
