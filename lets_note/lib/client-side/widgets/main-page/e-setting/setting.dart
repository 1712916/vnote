import 'package:flutter/material.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Column(
        children: [
          simpleButton(label: "Đăng xuất", doFuction: () async {
            Provider.of<LoginProvider>(context,listen: false).changeStatus();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setInt("userId", null);
          })
        ],
      ),
    );
  }
}
