import 'package:flutter/material.dart';
import 'package:lets_note/client-side/controller/data-controller.dart';
import 'package:lets_note/client-side/models/today-response-model.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
 import 'package:lets_note/client-side/widgets/custom-widgets/button.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/strings.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/text-type.dart';
import 'package:lets_note/client-side/widgets/main-page/a-home/check-list.dart';
import 'package:provider/provider.dart';

import 'simple-note.dart';

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
onGenerateRoute: (RouteSettings settings){
return MaterialPageRoute(
    settings: settings,
    builder: (context){
      switch(settings.name){
        case '/':
            return Home();
        case SimpleNotePage.routeName:
          return SimpleNotePage();
        case CheckListPage.routeName:
          return CheckListPage();
        default:
          return Home();
      }
    });
},
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Payload> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var response=DataController.getTodayData(userId: Provider.of<LoginProvider>(context,listen: false).userId);
    print("$response");
    data= List<Payload>.from(response["payload"].map((x) => Payload.fromJson(x)));
  print("data $data");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Text(
            choiceFunctionTitle,
            style: CustomTextType.title,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              width: double.infinity,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FeatureButton(
                    title: "Ghi chú",
                    iconData: Icons.rate_review,
                    doFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SimpleNotePage()));
                    },
                  ),
                  FeatureButton(
                    title: "Chi tiêu",
                    iconData: Icons.attach_money_rounded,
                  ),
                  FeatureButton(
                    title: "Lời nhắc",
                    iconData: Icons.add_alarm_rounded,
                  ),
                  FeatureButton(
                    title: "Check list",
                    iconData: Icons.check_circle_outline_rounded,
                    doFunction: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckListPage()));
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: data
                    .map((e) => ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageFactory.getType(
                                        type: e.typeNote,dataId: e.id)));
                          },
                            leading: Icon(iconDictionary[e.typeNote]),
                          title: Text(e.title),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Map iconDictionary = {
 0: Icons.rate_review,
  1: Icons.attach_money_rounded,
  2: Icons.add_alarm_rounded,
  3: Icons.check_circle_outline_rounded,
};

class PageFactory {
  static Widget getType({int type, int dataId}) {
    switch (type) {
      case 0:
        {
          return SimpleNotePage(
            dataId: dataId,
          );
        }
        break;
      case 1:
        {
          return SimpleNotePage(
            dataId: dataId,
          );
        }
        break;
      case 3:
        {
          return SimpleNotePage(
            dataId: dataId,
          );
        }
        break;
      case 4:
        {
          return CheckListPage(
            dataId: dataId,
          );
        }
        break;
    }
  }
}

