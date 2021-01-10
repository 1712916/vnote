import 'package:flutter/material.dart';
import 'package:lets_note/client-side/controller/data-controller.dart';
import 'package:lets_note/client-side/provider/login-provider.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/snack-bar.dart';
import 'package:lets_note/server-side/models/simple-note.dart';
import 'package:provider/provider.dart';

class SimpleNotePage extends StatefulWidget {
  static const String routeName = '/simple-page';

  int dataId;
  SimpleNotePage({this.dataId});
  @override
  _SimpleNotePageState createState() => _SimpleNotePageState();
}

class _SimpleNotePageState extends State<SimpleNotePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController titleController;
  TextEditingController contentController;
  SimpleNoteModel dataResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController=TextEditingController();
    contentController=TextEditingController();

    if(this.widget.dataId!=null){
      var response=DataController.getDataById(id: this.widget.dataId);
      dataResponse= SimpleNoteModel.fromJson(response);

      titleController.text=dataResponse.title;
      contentController.text=dataResponse.content;
    }else{
      dataResponse=SimpleNoteModel();
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back_rounded),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Ghi chú"),
        actions: [
          TextButton(onPressed: _redo, child: Text("Redo"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
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
              TextField(
                controller: contentController,
                maxLines: 20,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Ghi chú'),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: Icon(Icons.check),
      ),
    );
  }
  _redo(){
    titleController.text=dataResponse.title;
    contentController.text=dataResponse.content;
  }
  _save(  ){
    SimpleNoteModel newNote;
    if(dataResponse.id!=null){
      setState(() {
        dataResponse.title=titleController.text;
        dataResponse.content=contentController.text;
      });
      newNote=dataResponse;

    }else{
      newNote=SimpleNoteModel(title:titleController.text,content:contentController.text,userId:Provider.of<LoginProvider>(context,listen: false).userId,
          dateCreated: DateTime.now(),dateUpdate: DateTime.now());
    }


    var response=DataController.updateDataById(id: newNote.id,datum: newNote);
    print(response);
    if(response>=0){
      globalKey.currentState.showSnackBar(mySnackBar(title: "Đã lưu", okeFunction: (){}));
    }else{
      globalKey.currentState.showSnackBar(mySnackBar(title: "Lỗi", okeFunction: (){}));
    }
  }
}
