// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// class TimerApp extends StatefulWidget {
//   const TimerApp({super.key});
//
//   @override
//   State<TimerApp> createState() => _TimerAppState();
// }
//
// class _TimerAppState extends State<TimerApp> {
//   List mas = [[1, 0 ,1], [0, 1, 1], [1 , 1, 1], [0, 0, 1]];
//   int _Counter = 0;
//   late Timer _timer;
//
//   void startTimer(){
//     _Counter = 0;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_Counter <= 10){
//         setState(() {
//           _Counter ++;
//         });
//       } else{
//         _timer.cancel();
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('TETRIS'),
//           centerTitle: true,
//           backgroundColor: Colors.green,
//         ),
//         body: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               Text('$_Counter', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),),
//               SizedBox(height: 25,),
//               ElevatedButton(onPressed: (){
//                 startTimer();
//               },style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black
//               ),
//                   child: Text(
//                     'Start Timer',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       //backgroundColor: Colors.red
//                     ),)),
//               SizedBox(
//                   height: 400,
//
//                   child: GridView.builder(
//
//                       shrinkWrap: true,
//                       itemCount: 5,
//                       gridDelegate:
//                       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisExtent: 280.0,
//                       ),
//                       itemBuilder: (context, idex){
//                         Container(
//                           height: 5,
//                           width: 5,
//                           color: Colors.blue,
//                         );
//                       }
//                   )
//               )]
//         ));
//   }
// }
