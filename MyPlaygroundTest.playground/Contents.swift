// String
"hello"

// Int
12

// Double
0.4

// Bool
true
false

// Declare
var myVar: String = "hello"
print(myVar)

myVar = "world"
print(myVar)

var myInt: Int = 13
print(myInt)


// it can guess the right data type
var a = 13
print(a)

// Constant
let myConst: String = "hello"
print(myConst)

// Cannot be changed, error:
// myConst="me"



import UIKit

// function
func myFunc1(){
    let a = 10
    let b = 10
    print(a+b)
}
myFunc1()

// with input
func myFunc2(a:Int)-> Void{
    let b = 20
    print(a+b)
}
//need to right input parameter label
myFunc2(a:3)

// with input
func myFunc3(a:Int) -> Int{
    let b = 20
    print(a+b)
    return a+b
}
//need to right input parameter label
let thisValue = myFunc3(a: 3)

// argument label: firstNumber, outside function reference
// argument name: a, inside function reference
func myFunc3(firstNumber a: Int, secondNumber b:Int = 0) -> Int{
    return a+b
}
myFunc3(firstNumber: 1, secondNumber: 2)


func myFunc4(_ a: Int, _ b:Int = 0) -> Int{
    return a+b
}
myFunc4(3,5)

//best practice : no parameter label
