import 'package:flutter/material.dart';
import 'package:lets_note/client-side/controller/login.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/space.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController accountController;
  TextEditingController passwordController;
  String message="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountController=TextEditingController();
    passwordController=TextEditingController();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    accountController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Note theo cách của bạn",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200
                ),),
              Space(),
              TextField(
                controller: accountController,
                decoration: InputDecoration(
                    labelText: "Tài khoản"
                ),
              ),
              Space(),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: "Mật khẩu"
                ),
              ),
              Space(),
              RaisedButton(onPressed: (){
                setState(() {
                  message="";
                });
                 var response= LoginController.login(userPassword:  passwordController.text,userAccount: accountController.text);

                if(response['status']==200){
                  Provider.of<LoginProvider>(context,listen: false).changeStatus();
                  Provider.of<LoginProvider>(context,listen: false).updateData(userId: response['payload']['userId'],userAccount:response['payload']['userAccount'],userName: response['payload']['userName']);
                  print("data ${     Provider.of<LoginProvider>(context,listen: false).userId}");
                }else{
                  setState(() {
                    message="Đăng nhập thất bại!";
                  });
                }
                 },child: Text("Đăng nhập"),),
              Text(message)
            ],
          ),
        ),
      ),
    );
  }
}
