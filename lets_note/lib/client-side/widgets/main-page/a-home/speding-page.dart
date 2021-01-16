import 'package:flutter/material.dart';
import 'package:lets_note/client-side/controller/data-controller.dart';
import 'package:lets_note/client-side/models/spending-type-model.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/activity-page/spending-type-manager-page.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/snack-bar.dart';
import 'package:lets_note/server-side/mockup-data/data.dart';
import 'package:lets_note/server-side/models/spending.dart';
import 'package:provider/provider.dart';

class SpendingPage extends StatefulWidget {
  static const String routeName = '/spending-page';

  int dataId;
  SpendingPage({this.dataId});
  @override
  _SpendingPageState createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  SpendingModel dataResponse;
  TextEditingController moneyController;
  TextEditingController noteController;
  TextEditingController selectedDateController;
  TextEditingController selectedTimeController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moneyController = TextEditingController();
    noteController = TextEditingController();
    selectedDateController=TextEditingController();
    selectedTimeController=TextEditingController();

    if (this.widget.dataId != null) {
      var response = DataController.getDataById(id: this.widget.dataId);
      dataResponse = SpendingModel.fromJson(response);
      moneyController.text = dataResponse.money.toString();

      noteController.text = dataResponse.note;


    } else {
      dataResponse = SpendingModel(spendingType: SpendingTypeList.getDefault());

    }
    if(dataResponse.selectedDate!=null){
    selectedDateController.text=  "${dataResponse.selectedDate.toLocal()}".split(' ')[0];
    }else{
      dataResponse.selectedDate=DateTime.now();
      selectedDateController.text=   "${dataResponse.selectedDate.toLocal()}".split(' ')[0];
    }
    if(dataResponse.selectedTime!=null){
      selectedTimeController.text=     "${dataResponse.selectedTime.hour}h - ${dataResponse.selectedTime.minute}p ";
    }else{
      dataResponse.selectedTime=TimeOfDay.now();
      selectedTimeController.text=   "${dataResponse.selectedTime.hour}h - ${dataResponse.selectedTime.minute}p ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text("Chi tiêu"),
        actions: [TextButton(onPressed: _redo, child: Text("Redo"))],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    icon: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Center(
                            child: Text(getSymbolSpendingType(
                                title: dataResponse.spendingType.title)))),
                    onPressed: () {
                      var data0=SpendingTypeList.spending;
                      var data1=SpendingTypeList.income;
                      showModalBottomSheet(
                        backgroundColor: Colors.white30,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 400,
                              child: DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    Icon(Icons.drag_handle),
                                    Divider(color: Colors.white,),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: TabBar(
                                              tabs: [
                                                Tab(
                                                  child: Text("Chi tiêu"),
                                                ),
                                                Tab(
                                                  child: Text("Thu nhập"),
                                                )
                                              ],
                                            ),
                                            width: 200,
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.settings),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SpendingTypeManagerPage())) ;

                                            })
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          _buildListType(
                                              data0),
                                          _buildListType(
                                              data1),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
                Expanded(
                    child: TextField(
                  controller: moneyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Tiền",
                    hintText: "Ví dụ: 15000",
                  ),
                ))
              ],
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.date_range), onPressed: (){
                  _selectDate(context);
                }),
                Expanded(
                    child: TextField(
readOnly: true,
                      controller: selectedDateController,
                  decoration: InputDecoration(
                    labelText: "Ngày tháng",

                  ),
                ))
              ],
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.watch_later_outlined), onPressed: (){
                  _selectTime(context);
                }),
                Expanded(
                    child: TextField(
                      readOnly: true,
                      controller: selectedTimeController,
                  decoration: InputDecoration(

                    labelText: "Thời gian",
                  ),
                ))
              ],
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.edit), onPressed: null),
                Expanded(
                    child: TextField(
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: "Ghi chú",
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: Icon(Icons.check),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this.dataResponse.selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked !=  this.dataResponse.selectedDate)
      setState(() {
        this.dataResponse.selectedDate = picked;
        selectedDateController.text=  "${dataResponse.selectedDate.toLocal()}".split(' ')[0];
      });
  }
  void _selectTime(BuildContext context) async{

    TimeOfDay selectedTimeRTL = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
    );
    if (selectedTimeRTL != null && selectedTimeRTL !=  this.dataResponse.selectedTime)
      setState(() {
        this.dataResponse.selectedTime = selectedTimeRTL;
        selectedTimeController.text=   "${dataResponse.selectedTime.hour}h - ${dataResponse.selectedTime.minute}p ";
      });
  }
  _redo() {}
  _save() {
    SpendingModel newNote;
    if (dataResponse.id != null) {
      setState(() {
        dataResponse.money = int.parse(moneyController.text);
        dataResponse.note = noteController.text;
      });
      newNote = dataResponse;
    } else {
      newNote = SpendingModel(
          spendingType: dataResponse.spendingType,
          money: int.parse(moneyController.text),
          note: noteController.text,
          userId: Provider.of<LoginProvider>(context, listen: false).userId,
          dateCreated: DateTime.now(),
          dateUpdate: DateTime.now());
    }

    var response =
        DataController.updateDataById(id: newNote.id, datum: newNote);
    print(response);
    if (response >= 0) {
      if (dataResponse.id == null) {
        setState(() {
          dataResponse.id = response;
        });
      }

      globalKey.currentState
          .showSnackBar(mySnackBar(title: "Đã lưu", okeFunction: () {}));
    } else {
      globalKey.currentState
          .showSnackBar(mySnackBar(title: "Lỗi", okeFunction: () {}));
    }
  }

  _buildListType(List<SpendingType> data) {
    return (data==null||data.length == 0)
        ? Center(
            child: Text("Không có dữ liệu"),
          )
        : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  setState(() {
                    dataResponse.spendingType = data[index];
                  });
                  Navigator.pop(context);
                },
                title: Text(data[index].title),
              );
            });
  }


}

String getSymbolSpendingType({String title}) {
  var listSplitString = title.split(" ");
  print(listSplitString);
  String rs = "";
  for (int i = 0; i < listSplitString.length; i++) {
    rs += listSplitString[i][0].toUpperCase();
  }

  return rs;
}

void main() {
  print("hello ${getSymbolSpendingType(title: "Mua quần áo")}");
}
