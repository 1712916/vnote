import 'package:flutter/material.dart';
import 'package:lets_note/client-side/controller/data-controller.dart';
import 'package:lets_note/client-side/models/date-format-model.dart';
import 'package:lets_note/client-side/models/today-response-model.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/main-page/a-home/home.dart';
 import 'package:provider/provider.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Payload> data = [];
  List<String> _types =
  ["Tất cả","Ghi chú","Chi tiêu","Check list"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentType;
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentType = _dropDownMenuItems[0].value;
    super.initState();
    _onLoadData();
  }


  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String type in _types) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: type,
          child: new Text(type)
      ));
    }
    return items;
  }
  void changedDropDownItem(String selectedType) {
    _filterByType(_types.indexOf(selectedType)-1);
    setState(() {
      _currentType = selectedType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton(
                  dropdownColor: Colors.black,
                  value: _currentType,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),

              ],
            ),
            Expanded(child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
              return ListTile(
                onTap: ()   {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageFactory.getType(
                              type: data[index].typeNote,dataId: data[index].id))).then((value) {

                  });

                },
                leading: Icon(iconDictionary[data[index].typeNote]),
                title: Text(data[index].title),
               subtitle: Text("date created: ${MyFormatDate.getDateString(dateTime: data[index].dateCreated)} date update:  ${MyFormatDate.getDateString(dateTime: data[index].dateUpdate)}"),
              );
            } ))
          ],
        ),
      ),
    );
  }
  _onLoadData()   {
    var response=DataController.searchData(userId: Provider.of<LoginProvider>(context,listen: false).userId,filter: {});

    setState(() {
      data= List<Payload>.from(response["payload"].map((x) => Payload.fromJson(x)));
    });
  }
  _filterByType(int type){
    var response=DataController.searchData(userId: Provider.of<LoginProvider>(context,listen: false).userId,filter: {
      "type":type
    });

    setState(() {
      data= List<Payload>.from(response["payload"].map((x) => Payload.fromJson(x)));
    });
  }
}
