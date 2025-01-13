import 'dart:io';

class Node {
  String value;
  Node? next;

  Node(this.value);
}

class LinkedList {
  Node? head;

  // Method to add elements to the LinkedList
  void append(String value) {
    if (head == null) {
      head = Node(value);
    } else {
      Node current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = Node(value);
    }
  }

  // Method to traverse and print in left to right
  void printLeftToRight(int terminalWidth) {
    Node? current = head;
    String buffer = '';
    while (current != null) {
      buffer += current.value;
      if (buffer.length >= terminalWidth) {
        printWithColor(buffer, true);
        buffer = '';
      }
      current = current.next;
    }
    if (buffer.isNotEmpty) {
      printWithColor(buffer, true);
    }
  }

  // Method to traverse and print in right to left
  void printRightToLeft(int terminalWidth) {
    Node? current = head;
    List<String> values = [];
    while (current != null) {
      values.add(current.value);
      current = current.next;
    }
    String buffer = '';
    for (int i = values.length - 1; i >= 0; i--) {
      buffer = values[i] + buffer;
      if (buffer.length >= terminalWidth) {
        printWithColor(buffer, false);
        buffer = '';
      }
    }
    if (buffer.isNotEmpty) {
      printWithColor(buffer, false);
    }
  }

  // Method to print string with alternating color
  void printWithColor(String text, bool leftToRight) {
    // Print in left to right, or right to left, based on direction
    if (leftToRight) {
      stdout.write('\x1B[32m$text\x1B[0m'); // Green color
    } else {
      stdout.write('\x1B[31m$text\x1B[0m'); // Red color
    }
    stdout.writeln();
  }

  // Method to alternate between normal and reverse printing
  void printAlternating(int terminalWidth) {
    bool leftToRight = true;
    while (head != null) {
      if (leftToRight) {
        printLeftToRight(terminalWidth);
      } else {
        printRightToLeft(terminalWidth);
      }
      leftToRight = !leftToRight;
    }
  }
}

void main() {
  // Initialize a LinkedList and string
  LinkedList list = LinkedList();
  String repeatString = "NAME";

  // Add the string to the LinkedList
  for (int i = 0; i < 50; i++) {
    list.append(repeatString[i % repeatString.length]);
  }

  // Set the terminal width
  int terminalWidth = 80; // For example, 80 characters wide

  // Print alternating text with color changes
  list.printAlternating(terminalWidth);
}
