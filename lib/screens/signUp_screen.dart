import 'package:flutter/material.dart';

import 'package:mobile_gakgak/widget/appBackground.dart';
import 'package:mobile_gakgak/screens/forgotPassword_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userCtrl = TextEditingController();
final emailCtrl = TextEditingController();
final passwordCtrl = TextEditingController();
final finalPasswordCtrl = TextEditingController();

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                      onPressed: () {
                        dispose();
                        Navigator.pop(context);
                      },
                    ),
                  ),
        
                  const SizedBox(height: 32),
        
                  // Title
                  const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
        
                  const SizedBox(height: 8),
        
                  // Subtitle
                  const Text(
                    'By Signing up, you agree to our Terms of Use.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
        
                  const SizedBox(height: 32),

                  // Email label
                  const TextLabel(
                    label: 'Username',
                  ),
        
                  const SizedBox(height: 8),
        
                  // user input
                  TFNormal(
                    hint: 'Your Username',
                    controller: userCtrl,
                  ),
        
                  const SizedBox(height: 8),
        
                  // Email label
                  const TextLabel(
                    label: 'Email',
                  ),
        
                  const SizedBox(height: 8),
        
                  // Email input
                  TFNormal(
                    hint: 'Your Email',
                    controller: emailCtrl,
                  ),
        
                  const SizedBox(height: 8),
        
                  // Password label
                  const TextLabel(
                    label: 'Password',
                  ),
        
                  const SizedBox(height: 8),
        
                  // Password input
                  TFPassword(
                    hint: 'Your password',
                    controller: passwordCtrl,
                  ),

                  const SizedBox(height: 8),
        
                  // Password label
                  const TextLabel(
                    label: 'Confirm Password',
                  ),
        
                  const SizedBox(height: 8),
        
                  // Password input
                  TFPassword(
                    hint: 'Confirm your password',
                    controller: finalPasswordCtrl,
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
                      onPressed: () async {
                        try {
                          if (passwordCtrl.text.trim() != finalPasswordCtrl.text.trim()) {
                            showInvalidLoginDialog(context, 'Passwords do not match.');
                          }
                          else if(userCtrl.text.trim().isEmpty){
                            showInvalidLoginDialog(context, 'Username cannot be empty.');
                          }
                          else
                          {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailCtrl.text.trim(),
                            password: passwordCtrl.text.trim(),
                            );
                            await credential.user!.updateDisplayName(userCtrl.text.trim());
                            await credential.user!.reload();
                            showValidLoginDialog(context);
                            dispose();
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showInvalidLoginDialog(context, 'The password is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showInvalidLoginDialog(context, 'The account already exists');
                          } else {
                            showInvalidLoginDialog(context, 'The email or password is invalid');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text(
                        'Sign Up',
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
        
                  // Facebook button
                  SocialButton(
                    icon: Icons.facebook,
                    text: 'Sign up with Facebook',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForPasScreen(),
                        )
                      );
                    },
                  ),
        
                  const SizedBox(height: 12),
                  
                  // Google button
                  SocialButton(
                    icon: Icons.g_mobiledata,
                    text: 'Sign up with Google',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForPasScreen(),
                        )
                      );
                    },
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

class TFNormal extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  
  const TFNormal({
    super.key,
    required this.hint,
    required this.controller,
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
      controller: controller,
    );
  }
}

class TextLabel extends StatelessWidget {

  final String label;
  const TextLabel({
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
  final TextEditingController controller;

  const TFPassword({
    super.key,
    required this.hint,
    required this.controller,
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
      controller: widget.controller,
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

void showInvalidLoginDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.close, color: Colors.red),
          SizedBox(width: 8),
          Text('Sign up Failed'),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK', style: TextStyle(color: Color.fromRGBO(36, 36, 36, 1))),
        ),
      ],
    ),
  );
}

void showValidLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Text('Sign up Successful'),
        ],
      ),
      content: const Text("You may returned to Log In page."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK', style: TextStyle(color: Color.fromRGBO(36, 36, 36, 1))),
        ),
      ],
    ),
  );
}

void dispose() {
  userCtrl.clear();
  emailCtrl.clear();
  passwordCtrl.clear();
  finalPasswordCtrl.clear();
}