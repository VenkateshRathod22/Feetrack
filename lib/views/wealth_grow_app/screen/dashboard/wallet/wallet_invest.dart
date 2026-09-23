import 'package:flutter/material.dart';
import 'package:vlr/services/custom_text.dart';

class WalletInvest extends StatelessWidget {
  const WalletInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText("Wallet Screen"),
      ),
    );
  }
}
