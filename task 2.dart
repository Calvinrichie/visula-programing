
import 'dart:io' ;

void main (){
print ("Enter kg of apple(s):");
int?number1 = int.parse(stdin.readLineSync()!);
print ("Enter kg of orange(s):");
int?number2 = int.parse(stdin.readLineSync()!);
var apple = 5000;
var orange = 4000;

int price = ((apple*number1)+(orange*number2)) ;

print ("total price Rp: $price");

}