import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class TSplashScreen extends StatefulWidget {
  const TSplashScreen({super.key});

  @override
  State<TSplashScreen> createState() => _TSplashScreenState();
}

class _TSplashScreenState extends State<TSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
    
    // Start navigation after animations are set up
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToMain();
    });
  }

  Future<void> _navigateToMain() async {
    try {
      // Wait for splash animation
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted || !context.mounted) return;

      // Navigate to main screen
      context.goNamed('main');
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/splash_screen.jpg',
            fit: BoxFit.cover,
          ),
          // Centered Logo with Shimmer and Scale Animation
          Center(
            child: ScaleTransition(
              scale: _animation,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.white.withOpacity(0.5),
                period: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/images/sylonow_white_logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 