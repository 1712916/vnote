import 'package:lets_note/server-side/models/user-account.dart';

class UserAccountData {
  static int _currentId=2;
  static List<UserAccount> accounts = [
    UserAccount(
        userId: 0,
        userName: "Kiều Phong",
        userAccount: "boss",
        userPassword: "1"),
    UserAccount(
        userId: 1,
        userName: "Vịnh Ngô",
        userAccount: "vinhngo",
        userPassword: "1"),
  ];

  static checkUserAccount({String userAccount, String userPassword}) {
    var result;

    for (int i = 0; i < accounts.length; i++) {
      if (accounts[i].userAccount == userAccount &&
          accounts[i].userPassword == userPassword) {
        result = {
          "status": 200,
          "payload": {
            "userId": accounts[i].userId,
            "userAccount": accounts[i].userAccount,
            "userName": accounts[i].userName
          }
        };
        return result;
      }
    }

    result = {
      "status": 404,
    };
    return result;
  }
  static createNewAccount({String userAccount, String userPassword}){
    //check userAccount

    //add
    UserAccount newUser= UserAccount(
        userId: _currentId++,
        userName: userAccount+"_name",
        userAccount: userAccount,
        userPassword: userAccount);
    accounts.add(newUser);
    return {
      "status": 200,
    };
  }
}

void main() {
  print(UserAccountData.checkUserAccount(
      userAccount: "boss", userPassword: "1"));
  print(UserAccountData.createNewAccount(
      userAccount: "bossxomlut", userPassword: "1231213"));

}
