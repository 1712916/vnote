import 'package:flutter/material.dart';


class CheckItem {
  String content;
  bool isChecked;


  CheckItem({this.content, this.isChecked});
}

class CheckListPage extends StatefulWidget {
  static const String routeName = '/checklist-page';
  String dataId;
  CheckListPage({this.dataId});
  @override
  _CheckListPageState createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  TextEditingController titleController,newController;

  List<CheckItem> data = [
  ];
  List<TextEditingController> textController=[];
  @override
  void initState() {
    // TODO: implement initState
    titleController=TextEditingController();
    newController=TextEditingController();
     initTextController();
    print("id: ${this.widget.dataId}");
    super.initState();
  }
  initTextController() {
      for(int i=0;i<data.length;i++){
      TextEditingController textEditingController=new TextEditingController();
      textEditingController.text=data[i].content;
      textController.add(textEditingController);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      CheckItem checkItem=new CheckItem(isChecked: false, content: newController.text);
                      data.add(checkItem);
                      TextEditingController textEditingController=new TextEditingController();
                      textEditingController.text=newController.text;
                      textController.add(textEditingController);
                      newController.text="";
                    });
                  },
                ),
              ),
              Divider(
                height: 2,
                color: Colors.grey,
              ),
              Expanded(
                child: ReorderableListView(
                  children: List.generate(
                      data.length,
                      (index) => ListTile(
                            key: ValueKey(data[index]),
                            title:  TextField(
                               controller: textController[index],
                              decoration: InputDecoration(
                                  border: InputBorder.none ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                    icon: Icon(Icons.delete), onPressed: () {
                                      setState(() {
                                        data.remove(data[index]);
                                        textController.remove(textController[index]);
                                      });
                                }),
                                Icon(Icons.drag_indicator_sharp)
                              ],
                            ),
                            leading:  Checkbox(
                              value: data[index].isChecked,
                              onChanged: (value){
                                setState(() {
                                  data[index].isChecked=value;
                                });
                              },
                            ),

                          )),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      // These two lines are workarounds for ReorderableListView problems
                      if (newIndex > data.length) newIndex = data.length;
                      if (oldIndex < newIndex) newIndex--;

                      CheckItem item = data[oldIndex];
                      TextEditingController controller=textController[oldIndex];
                      data.remove(item);
                      textController.remove(controller);
                      data.insert(newIndex, item);
                      textController.insert(newIndex, controller);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
