import 'package:lets_note/server-side/constants.dart';
import 'package:lets_note/server-side/server-main.dart';

class LoginServices {
  static Map loginRequest({String userAccount, String userPassword}){

    var response=ServerManager.listenToRequest(requestName: ConstantRequestName.login,data: {
        'userAccount':userAccount,
          'userPassword':userPassword
      });
    return response;
  }


  }
