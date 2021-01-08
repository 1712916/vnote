import 'package:flutter/material.dart';

class SimpleNotePage extends StatefulWidget {
  static const String routeName = '/simple-page';
  String title;
  String content;
  int dataId;
  SimpleNotePage({this.dataId,this.content,this.title});
  @override
  _SimpleNotePageState createState() => _SimpleNotePageState();
}

class _SimpleNotePageState extends State<SimpleNotePage> {
  TextEditingController titleController;
  TextEditingController contentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController=TextEditingController();
    contentController=TextEditingController();
    print("id: ${this.widget.dataId}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ghi chú"),
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
    );
  }
}
