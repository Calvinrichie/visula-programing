import 'dart:io';

class Node {
  String data;
  Node? next;

  Node(this.data);
}

class LinkedList {
  Node? head;

  void append(String data) {
    Node newNode = Node(data);
    if (head == null) {
      head = newNode;
    } else {
      Node current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = newNode;
    }
  }

  void printList(int terminalWidth) {
    Node? current = head;
    bool leftToRight = true;
    int colorIndex = 0;

    final colors = [
      '\x1B[31m', // Red
      '\x1B[32m', // Green
      '\x1B[33m', // Yellow
      '\x1B[34m', // Blue
      '\x1B[35m', // Magenta
      '\x1B[36m', // Cyan
      '\x1B[0m',  // Reset
    ];

    while (current != null) {
      String line = '';
      int count = 0;

      while (current != null && count < terminalWidth) {
        line += current.data;
        current = current.next;
        count++;
      }

      // Print the line in the chosen color
      stdout.write(colors[colorIndex % colors.length]);
      if (leftToRight) {
        print(line);
      } else {
        print(line.split('').reversed.join());
      }

      // Alternate direction and increment color index
      leftToRight = !leftToRight;
      colorIndex++;
    }
    
    // Reset color at the end
    stdout.write(colors.last);
  }
}

void main() {
  final linkedList = LinkedList();
  final string = 'NAME';

  // Create a repeating linked list
  for (int i = 0; i < 50; i++) { // Adjust for desired length
    linkedList.append(string[i % string.length]);
  }

  // Print the linked list
  final terminalWidth = stdout.terminalColumns;
  linkedList.printList(terminalWidth);
}
