import 'package:flutter/material.dart';

class FeatureButton extends StatefulWidget {
  String title;
  IconData iconData;
  Function doFunction;

  FeatureButton({this.title, this.iconData, this.doFunction});

  @override
  _FeatureButtonState createState() => _FeatureButtonState();
}

class _FeatureButtonState extends State<FeatureButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.doFunction();
      },
      child: Container(
 margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(

          color: Colors.white24,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 40,

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [Icon(widget.iconData), SizedBox(width: 8,),Text(widget.title)],
        ),
      ),
    );
  }
}

Widget simpleButton({String label, Function doFuction}){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.deepPurple[700],
        borderRadius:
        BorderRadius.all(Radius.circular(4.0))),
    child: FlatButton(
        onPressed: () async {
          doFuction();
        },
        child: Center(
          child: Text(
            label.toUpperCase(),
          ),
        )),
  );
}
