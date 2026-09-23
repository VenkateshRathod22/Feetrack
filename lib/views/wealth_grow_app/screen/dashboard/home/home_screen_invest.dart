import 'package:flutter/material.dart';
import 'package:vlr/services/custom_text.dart';

class HomeScreenInvest extends StatelessWidget {
  const HomeScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText("HomeScreen"),
      ),
    );
  }
}
