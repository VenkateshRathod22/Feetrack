import 'package:flutter/material.dart';
import 'package:vlr/services/custom_text.dart';

class InvestmentScreenInvest extends StatelessWidget {
  const InvestmentScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText("Investment Screen"),
      ),
    );
  }
}
