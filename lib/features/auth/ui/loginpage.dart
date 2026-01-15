import 'package:flutter/material.dart';

import 'package:flutter_application_1/core/routing/app_routes.dart';
import 'package:flutter_application_1/core/services/session_service.dart';
import 'package:flutter_application_1/features/auth/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  int _currentPage = 0;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> sliderTexts = [
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    'Industry standard dummy text ever since the 1500s.',
    'Make a type specimen book and scrambled it.',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (_emailController.text == 'bhavin@triveni.com' &&
        _passwordController.text == 'bhavin@123') {
      SessionService.login(
        User(id: '1', name: 'Bhavin Mistry', email: _emailController.text),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.shell);
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [_rightLoginSection(), _leftOverlayCard()]),
    );
  }

  // ---------------- LEFT OVERLAY CARD ----------------

  Widget _leftOverlayCard() {
    return Positioned(
      left: 40,
      top: 40,
      bottom: 40,
      child: Container(
        width: 420,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0A5CFF),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Diamond icon
            const Icon(Icons.diamond_outlined, color: Colors.white, size: 120),

            const Spacer(),

            // Sliding content box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 50),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                height: 120,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: sliderTexts.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome to MyColour',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          sliderTexts[index],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            _pageIndicator(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        sliderTexts.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: _currentPage == index ? 255 : 120,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  // ---------------- RIGHT LOGIN SECTION ----------------

  Widget _rightLoginSection() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 120),
        child: SizedBox(
          width: 420,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.diamond_outlined,
                        color: Color(0xFF0A5CFF),
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'MyColour',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A5CFF),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Center(
                  child: Text(
                    'Login to Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A5CFF)),
                  ),
                ),
                const Center(
                  child: Text(
                    '_______________',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Welcome Back, Please login to continue',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 20),

                const Text('Email'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Please enter your email',
                    prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF0A5CFF)),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.contains('@') ? null : 'Enter valid email',
                ),

                const SizedBox(height: 20),

                const Text('Password'),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Please enter your password',
                    prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF0A5CFF)),
                    border: OutlineInputBorder(),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password?'),
                  ),
                ),

                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Log In'),
                  ),
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Don't have an account? Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
