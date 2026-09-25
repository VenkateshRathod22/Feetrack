import 'package:flutter/material.dart';
import 'package:vlr/services/custom_text.dart';
import 'package:vlr/views/base/common_button.dart';

class ProfileScreenInvest extends StatelessWidget {
  const ProfileScreenInvest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(onTap: (){
          
        }, title: "Logout",),
      ),
    );
  }
}
