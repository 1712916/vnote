import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lets_note/client-side/controller/data-controller.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/snack-bar.dart';
import 'package:lets_note/server-side/models/note-datum.dart';
import 'package:provider/provider.dart';




class CheckListPage extends StatefulWidget {
  static const String routeName = '/checklist-page';
  int dataId;
  CheckListPage({this.dataId});
  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController,newController;
  CheckListModel dataResponse;

  List<TextEditingController> contentController=[];
  @override
  void initState() {
    // TODO: implement initState
    titleController=TextEditingController();
    newController=TextEditingController();

    if (this.widget.dataId != null) {
      var response = DataController.getDataById(id: this.widget.dataId);
      dataResponse = CheckListModel.fromJson(response);
    } else {
      dataResponse = CheckListModel( );
    }
    initTextController();
    titleController.text=dataResponse.title;
    super.initState();
  }
  initTextController() {
    if(dataResponse.content!=null){
      for(int i=0;i<dataResponse.content.length;i++){
        TextEditingController textEditingController=new TextEditingController();
        textEditingController.text=dataResponse.content[i].content;
        contentController.add(textEditingController);

      }
    }
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
      appBar: AppBar(
        title: Text("Check list"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Tiêu đề'),
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              ListTile(
                key: Key("new"),
                leading: Icon(Icons.fiber_new),
                title:  TextField(
                  controller: newController,
                  decoration: InputDecoration(
                      border: InputBorder.none ,hintText: "Thêm tại đây"),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    setState(() {
                      CheckDatum checkItem=new CheckDatum(isChecked: false, content: newController.text);
                      print(checkItem);
                      print(dataResponse.content);
                      if(dataResponse.content==null){
                        dataResponse.content=[];
                      }
                      dataResponse.content.add(checkItem);
                      TextEditingController textEditingController=new TextEditingController();
                      textEditingController.text=newController.text;
                      contentController.add(textEditingController);
                      newController.text="";
                    });
                  },
                ),
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              dataResponse.content==null?Container():Expanded(
                child: ReorderableListView(
                  children: List.generate(
                      dataResponse.content.length,
                          (index) => ListTile(
                        key: ValueKey(dataResponse.content[index]),
                        title:  TextField(
                          controller: contentController[index],
                          decoration: InputDecoration(
                              border: InputBorder.none ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            IconButton(
                                icon: Icon(Icons.delete), onPressed: () {
                              setState(() {
                                dataResponse.content.remove(dataResponse.content[index]);
                                contentController.remove(contentController[index]);
                              });
                            }),
                            Icon(Icons.drag_indicator_sharp)
                          ],
                        ),
                        leading:  Checkbox(
                          value: dataResponse.content[index].isChecked,
                          onChanged: (value){
                            setState(() {
                              dataResponse.content[index].isChecked=value;
                            });
                          },
                        ),

                      )),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      // These two lines are workarounds for ReorderableListView problems
                      if (newIndex > dataResponse.content.length) newIndex = dataResponse.content.length;
                      if (oldIndex < newIndex) newIndex--;

                      CheckDatum item = dataResponse.content[oldIndex];
                      TextEditingController controller=contentController[oldIndex];
                      dataResponse.content.remove(item);
                      contentController.remove(controller);
                      dataResponse.content.insert(newIndex, item);
                      contentController.insert(newIndex, controller);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: _save,
          child: Icon(Icons.check),
        )
    );
  }
  _save() {

    setState(() {
      dataResponse.title=titleController.text;
      dataResponse.dateUpdate=DateTime.now();
      for(int i=0;i<dataResponse.content.length;i++){
        dataResponse.content[i].content=contentController[i].text;
      }
    });
    if (dataResponse.id != null) {


    } else {
      dataResponse.dateCreated=DateTime.now();
      dataResponse.userId=Provider.of<LoginProvider>(context,listen: false).userId;
    }
    print("save___ ${dataResponse.toJson()}");
    var response =DataController.updateDataById(id: dataResponse.id, datum: dataResponse);
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
}
