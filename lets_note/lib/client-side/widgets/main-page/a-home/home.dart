import 'package:flutter/material.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/strings.dart';
import 'package:lets_note/client-side/widgets/custom-widgets/text-type.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          Text(choiceFunctionTitle, style: CustomTextType.title,),
          Container(
            height: 100,
            width: double.infinity,
          ),
          Divider(),
          Container(
            child:  Column(
              children: [Text("Hello"),
                Text("Hello"),
                Text("Hello"),
                Text("Hello"),
                Text("Hello"),
              ],
            ),

          ),


        ],
      ),
    );
  }
}
