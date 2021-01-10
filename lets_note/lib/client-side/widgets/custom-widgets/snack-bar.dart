import 'package:flutter/material.dart';

Widget mySnackBar  ({String title, Function okeFunction})=>SnackBar(
  content: Text(title),
  action: SnackBarAction(
    label: 'OKE',
    onPressed:okeFunction,
  ),
);
