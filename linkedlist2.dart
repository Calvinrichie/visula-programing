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
      '\x1B[31m', 
      '\x1B[32m', 
      '\x1B[33m', 
      '\x1B[34m', 
      '\x1B[35m', 
      '\x1B[36m', 
      '\x1B[0m',  
    ];

    while (current != null) {
      String line = '';
      int count = 0;

      while (current != null && count < terminalWidth) {
        line += current.data;
        current = current.next;
        count++;
      }

      
      stdout.write(colors[colorIndex % colors.length]);
      if (leftToRight) {
        print(line);
      } else {
        print(line.split('').reversed.join());
      }

      
      leftToRight = !leftToRight;
      colorIndex++;
    }
    
    
    stdout.write(colors.last);
  }
}

void main() {
  final linkedList = LinkedList();
  final string = 'NAME';

  
  for (int i = 0; i < 50; i++) { 
    linkedList.append(string[i % string.length]);
  }

  
  final terminalWidth = stdout.terminalColumns;
  linkedList.printList(terminalWidth);
}
