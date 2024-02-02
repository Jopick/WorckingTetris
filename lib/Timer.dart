import 'dart:async';
import 'dart:math';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taimer/piece.dart';
import 'package:taimer/pixel.dart';
import 'package:taimer/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
        (i) => List.generate(
            rowLength,
                (j) => null
        )
);
class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  int rowLength = 10;
  int colLength = 15;
  int currentScore = 0;
  int _Counter = 0;
  bool GameOver = false;
  //
  late Timer _timer;

  void startTimer() {
    _Counter = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //if (_Counter <= 30) {
        setState(() {
          _Counter ++;
        });
      //} else {

    });
  }
  //
  Piece currentPiece = Piece(type: Tetromino.L);
  void initState() {
    super.initState();
    startGame();
    startTimer();
  }


  void startGame() {
    currentPiece.creatPiece();
    Duration frameRate = Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop (Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checkLanding();
        if(GameOver == true){
          _timer.cancel();
          timer.cancel();
          showGameOver();
        }
        currentPiece.movePiece(Direction.down);
      });
    }
    );
  }
  //check for collision in a future position
  //true if a collision
  //false if not a collision
  void showGameOver(){
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[700],
      title: Text('Game Over',style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
      content: Text('Your points: $currentScore o_0', style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      actions: [TextButton(onPressed: (){
        resetGame();
        Navigator.pop(context);
      }, child: Text('Play Again', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),))],
    ));
  }
  void resetGame(){
    gameBoard = gameBoard = List.generate(
        colLength,
    (i) => List.generate(
        rowLength,
            (j) => null
    ));
    GameOver = false;
    currentScore = 0;
    _Counter = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //if (_Counter <= 30) {
      setState(() {
        _Counter ++;
      });});
    createNewPiece();
    startGame();

  }
  bool checkCollision (Direction direction) {
    for(int i = 0; i < currentPiece.position.length; i ++){
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if(direction == Direction.left){
        col -= 1;
      } else if(direction == Direction.right){
        col += 1;
      } else if(direction == Direction.down){
        row += 1;
      }
      if(row >= colLength || col < 0 || col >= rowLength){
        return true;
      }
    }
    return false;
  }


  void checkLanding(){
    if(checkCollision(Direction.down) || checkLanded()){
      for(int i = 0; i < currentPiece.position.length;i++){
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if(row >= 0 && col >= 0){
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  bool checkLanded(){
    for(int i = 0; i < currentPiece.position.length; i++){
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if(row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null){
        return true;
      }
    }
    return false;
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.creatPiece();
    if(isGameOver()){
      GameOver = true;
    }
  }

  void moveLeft(){
    if(!checkCollision(Direction.left)){
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight(){
    if(!checkCollision(Direction.right)){
      currentPiece.movePiece(Direction.right);
    }
  }


  void rotatePiece(){
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines(){
    for(int row = colLength - 1;row >= 0; row --){
      bool rowIsFull = true;

      for(int col = 0; col < rowLength; col ++){
        if(gameBoard[row][col] == null){
          rowIsFull = false;
          break;
        }
      }

      if(rowIsFull){
        for(int r = row; r > 0; r--){
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }
  //Game over

  bool isGameOver(){
    for(int col = 0; col < rowLength;col ++){
      if(gameBoard[0][col] != null){
        return true;
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title:
        Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Text(
            'TETRIS', style: TextStyle(color: Colors.grey[600], fontSize: 35, fontWeight: FontWeight.bold),),
        Column(children: [Icon(Icons.check_box_outline_blank,color: Colors.white,),
          Row(children: [
            Icon(Icons.check_box_outline_blank, color: Colors.white),
            Icon(Icons.check_box_outline_blank, color: Colors.white,),
            Icon(Icons.check_box_outline_blank, color: Colors.white,)])
            ]),]),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
    ),
      body:
      Column(children: [

        GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                primary: false,
                itemCount: 150,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
                itemBuilder: (context, index){
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
                  if(currentPiece.position.contains(index)){
                    return Pixel(
                        color: Colors.white,
                        child: index);

                  }else if(gameBoard[row][col] != null){
                    return Pixel(color: Colors.grey[700], child: index);
                  }else {
                    return Pixel(color: Colors.black, child: index);
                  }


                  }),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text('$_Counter',
                    style: TextStyle(
                        fontSize: 40, 
                        fontWeight: FontWeight.bold, color: Colors.black),),
                Icon(Icons.timer, size: 40,),
                Text(('sec.'), style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black),)
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                  children:[IconButton(onPressed: moveLeft,
                      icon: Icon(Icons.arrow_back_ios_new_sharp, size: 40,)),
                SizedBox(width: 55,),

                IconButton(onPressed: rotatePiece,
                icon: Icon(Icons.rotate_right, size: 45,),),
                    SizedBox(width: 55,),
                  IconButton(onPressed: moveRight,
                      icon: Icon(Icons.arrow_forward_ios_sharp, size: 45, ))]),
              SizedBox(height: 25,),
              SizedBox.fromSize(
                  //backgroundColor: Colors.black,

                  child: Text(
                    '$currentScore  lines',
                    style: TextStyle(
                      fontSize: 30,
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      //backgroundColor: Colors.red
                    ),)),
      ])
    );
  }
}
