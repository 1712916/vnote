import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_note/client-side/models/spending-type-model.dart';
import 'package:lets_note/server-side/mockup-data/data.dart';

class SpendingTypeManagerPage extends StatefulWidget {
  @override
  _SpendingTypeManagerPageState createState() => _SpendingTypeManagerPageState();
}

class _SpendingTypeManagerPageState extends State<SpendingTypeManagerPage>   with SingleTickerProviderStateMixin {
  TabController _tabController;
  TextEditingController spendingTypeController;
  final List<Tab> myTabs = <Tab>[
    Tab(child: Text("Chi tiêu"),),
    Tab(child: Text("Thu nhập"),),
  ];
  int page;
  int currentType=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page=0;
    spendingTypeController=TextEditingController();
    _tabController = new TabController(vsync: this, length: myTabs.length);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            if(page==1){
              setState(() {
                page=0;
              });
            }else{
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
        actions: page==0?null:[
          IconButton(icon: Icon(Icons.check), onPressed: _onSave)
        ],
        title: Text("Phân loại quản lý"),
        bottom: page==0?TabBar(
          controller: _tabController,
          tabs:myTabs,
        ):null,
      ),
      body: page==0?Column(
        children: [
          Expanded(child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                  itemCount: SpendingTypeList.spending.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: (){

                          SpendingTypeList.spending.remove(SpendingTypeList.spending[index]);
                          setState(() {

                          });
                        },
                      ),
                      title: Text(SpendingTypeList.spending[index].title),
                      trailing: IconButton(onPressed: (){
                        setState(() {
                          currentType=index;
                          spendingTypeController.text=SpendingTypeList.spending[index].title;
                          page=1;
                        });

                      },icon: Icon(Icons.edit),),
                    );
                  }),
              ListView.builder(
                  itemCount: SpendingTypeList.income.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: (){
                          SpendingTypeList.income.remove(SpendingTypeList.income[index]);
                          setState(() {
                          });
                        },
                      ),
                      title: Text(SpendingTypeList.income[index].title),
                      trailing: IconButton(onPressed: (){
                        setState(() {
                          currentType=index;
                          spendingTypeController.text=SpendingTypeList.spending[index].title;
                          page=1;
                        });
                      },icon: Icon(Icons.edit),),
                    );
                  }),
            ],
          )),
          TextButton(onPressed: (){
           setState(() {
             page=1;
           });
          }, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text("Thêm phân loại mới"),
            ],
          ))
        ],
      ):Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: spendingTypeController,
                decoration: InputDecoration(
                  labelText: "Nhập tên phân loại",
                  hintText: "Ví dụ: Đi chơi với người yêu"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSave(){

    if(_tabController.index==0){
       if(currentType==-1){
         SpendingTypeList.spending.insert(0, SpendingType(title: spendingTypeController.text,type: -1));
       }else{
         SpendingTypeList.spending[currentType].title=spendingTypeController.text;
       }

    }else if(_tabController.index==1){
      if(currentType==-1){
        SpendingTypeList.income.insert(0, SpendingType(title: spendingTypeController.text,type: 1));
      }else{
        SpendingTypeList.income[currentType].title=spendingTypeController.text;
      }

    }
    setState(() {
      page=0;
      currentType=-1;
    });
    spendingTypeController.text="";
  }
}
