import 'dart:collection';
class Node<T> extends LinkedListEntry<Node<T>> {
  T value;
  Entry(this.value);
  @override
  String toString() {
    return '$value';
  }
}

void main() {
  //create an empty linked list
  var linkedList = LinkedList<Node<int>>();

  print("The linkedList is : $linkedList");
}