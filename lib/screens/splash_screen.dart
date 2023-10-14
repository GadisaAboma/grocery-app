import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/app_routes.dart';
import 'package:grocery_app/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  var token;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      token = pref.getString("userToken");
      developer.log("token");
    });
    if (mounted) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (token != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
        }
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * .2,
            left: MediaQuery.of(context).size.height * .12,
            child: Image.asset("assets/logo.png"),
          ),
        ],
      ),
    );
  }
}
