import 'package:flutter/material.dart';

class Pixel extends StatelessWidget{
  var color;
  Pixel({super.key, required this.color, required var child});

  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(0.75),
    );
  }
}