// Deferred import
import 'package:clean_flutter/_shared/features/landing/views/page/landing_page.dart'
    deferred as landing;
import 'package:flutter/material.dart';

class LandingPageLoader extends StatefulWidget {
  const LandingPageLoader({super.key});

  @override
  State<LandingPageLoader> createState() => _LandingPageLoaderState();
}

class _LandingPageLoaderState extends State<LandingPageLoader> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadLandingPage();
  }

  Future<void> _loadLandingPage() async {
    await landing.loadLibrary();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return landing.LandingPage();
  }
}
