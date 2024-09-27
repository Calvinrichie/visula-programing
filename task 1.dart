import 'dart:math';
import 'dart:io' ;

void main() {

  print ("Enter number:");
  int?number = int.parse(stdin.readLineSync()!);
var rng = Random();
// ignore: unused_local_variable
var generate = new List.generate(number, (_) => rng.nextInt(100));

}