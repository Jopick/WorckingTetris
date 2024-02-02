import 'package:taimer/Timer.dart';

import 'values.dart';
int rowLength = 10;
int colLength = 15;
class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  void creatPiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      // case Tetromino.J:
      //   position = [-25, -15, -5, -6];
      //   break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-5, -6, -15, -14];
        break;
        // case Tetromino.Z:
        // position = [-17, -16, -6, -5];
        //   break;
      case Tetromino.T:
        position = [-5, -15, -25, -14];
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i ++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  int rotaitonState = 1;

  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotaitonState) {
          case 0:
          //0
          //0
          //0
          //0 0

          //get new posision
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }

            break;

          case 1:
          // 0 0 0
          //0
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            break;

          case 2:
          // 0 0
          //   0
          //   0
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            break;

          case 3:
          // 0 0 0
          //0
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            break;
        }
        break;

      case Tetromino.I:
        switch (rotaitonState) {
          case 0:
          //  0 0 0 0
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            break;
          case 1:
          //0
          //0
          //0
          //0
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            break;
        }
      case Tetromino.S:
        switch (rotaitonState) {
          case 0:
          //   0 0
          // 0 0
            newPosition = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            return;
          case 1:
          // 0
          // 0 0
          //   0
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            return;
          default:
        }
      case Tetromino.T:
        switch (rotaitonState) {
          case 0:
          // 0
          // 0 0
          // 0
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            return;
          case 1:
          // 0 0 0
          //   0
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            return;
          case 2:
          //   0
          // 0 0
          //   0
            newPosition = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            return;
          case 3:
            // 0
          // 0 0 0
            newPosition = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];

            if (picePositionIsValid(newPosition)) {
              position = newPosition;
              rotaitonState = (rotaitonState + 1) % 4;
            }
            return;
        default:
        }
      default:
    }
  }
    bool positionIsValid(int position) {
      int row = (position / rowLength).floor();
      int col = position % rowLength;

      if (row < 0 || col < 0 || gameBoard[row][col] != null) {
        return false;
      }
      else {
        return true;
      }
    }
    bool picePositionIsValid(List<int> piecePosition) {
      bool firstColo = false;
      bool lastColo = false;

      for (int pos in piecePosition) {
        if (!positionIsValid(pos)) {
          return false;
        }
        int col = pos % rowLength;

        if (col == 0) {
          firstColo = true;
        }
        if (col == rowLength - 1) {
          lastColo = true;
        }
      }
      return !(firstColo && lastColo);
  }
}