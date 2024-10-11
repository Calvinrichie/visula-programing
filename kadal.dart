import 'dart:async';
import 'dart:io';
import 'dart:math';

class Game {
  final int width;
  final int height;
  List<Point<int>> lizard;
  Point<int> food;
  int direction; // 0 = up, 1 = right, 2 = down, 3 = left
  bool gameOver = false;

  Game(this.width, this.height) {
    // Initialize the lizard
    lizard = [Point(width ~/ 2, height ~/ 2)];
    direction = 1; // Start moving right
    spawnFood();
  }

  void spawnFood() {
    Random random = Random();
    do {
      food = Point(random.nextInt(width), random.nextInt(height));
    } while (lizard.contains(food)); // Ensure food does not spawn on the lizard
  }

  void move() {
    if (gameOver) return;

    // Calculate new head position
    Point<int> head = lizard.first;
    Point<int> newHead;

    switch (direction) {
      case 0: newHead = Point(head.x, head.y - 1); break; // Up
      case 1: newHead = Point(head.x + 1, head.y); break; // Right
      case 2: newHead = Point(head.x, head.y + 1); break; // Down
      case 3: newHead = Point(head.x - 1, head.y); break; // Left
    }

    // Check for game over conditions
    if (newHead.x < 0 || newHead.x >= width || newHead.y < 0 || newHead.y >= height || lizard.contains(newHead)) {
      gameOver = true;
      return;
    }

    // Move the lizard
    lizard.insert(0, newHead);
    
    // Check if food is eaten
    if (newHead == food) {
      spawnFood(); // Spawn new food
    } else {
      lizard.removeLast(); // Remove the tail if not growing
    }
  }

  void changeDirection(int newDirection) {
    // Prevent reversing direction
    if ((direction + 2) % 4 != newDirection) {
      direction = newDirection;
    }
  }

  void display() {
    stdout.write('\x1B[2J\x1B[0;0H'); // Clear the screen
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        Point<int> point = Point(x, y);
        if (lizard.contains(point)) {
          stdout.write('*');
        } else if (point == food) {
          stdout.write('@');
        } else {
          stdout.write(' ');
        }
      }
      stdout.writeln();
    }
  }

  bool isGameOver() {
    return gameOver;
  }
}

void main() {
  final game = Game(20, 10);
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    game.move();
    game.display();
    if (game.isGameOver()) {
      timer.cancel();
      print('Game Over! Final length: ${game.lizard.length}');
    }
  });

  // Listen for user input to change direction
  stdin.lineMode = false;
  stdin.echoMode = false;
  stdin.listen((List<int> event) {
    if (event.isNotEmpty) {
      switch (event[0]) {
        case 119: game.changeDirection(0); break; // W - Up
        case 100: game.changeDirection(1); break; // D - Right
        case 115: game.changeDirection(2); break; // S - Down
        case 97:  game.changeDirection(3); break; // A - Left
      }
    }
  });
}
