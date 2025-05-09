import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'main_page.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key, required this.title});
  final String title;

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _showSecondText = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: const Offset(0, -0.8),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSecondText = true;
        });
        Future.delayed(const Duration(seconds: 1), _requestPermissions);
      }
    });

    _controller.forward();
  }

  Future<void> _requestPermissions() async {
    if (await Permission.bluetoothConnect.isDenied) {
      await Permission.bluetoothConnect.request();
    }

    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }

    if (await Permission.bluetoothConnect.isGranted &&
        await Permission.location.isGranted) {
      _navigateToMainPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissions are required to proceed.')),
      );
    }
  }

  void _navigateToMainPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainPage(title: "ScooterX",)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _animation,
              child: Text(
                'Welcome to ${widget.title}!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _showSecondText ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const Text(
                'Please accept the required permissions',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
