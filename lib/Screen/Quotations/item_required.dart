import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';

class ItemRequiredScreen extends StatefulWidget {
  const ItemRequiredScreen({Key? key}) : super(key: key);

  @override
  _ItemRequiredScreenState createState() => _ItemRequiredScreenState();
}

class _ItemRequiredScreenState extends State<ItemRequiredScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: Text("Item Required")),

          ],
        ),
      ),
    );
  }
}
