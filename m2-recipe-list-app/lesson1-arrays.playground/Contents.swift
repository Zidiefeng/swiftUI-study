import UIKit

// Array can only store data of a single type
// Create an instance of array, it's empty
var myArray:[Int] = [Int]()


myArray.append(10)
myArray.append(100)
myArray.append(1000)
print(myArray)

// index starting from 0
print(myArray[0])

// assign to an index
myArray[0]=0
print(myArray[0])

//remove an element by index
myArray.remove(at: 1)
print(myArray)

var arrayB:[Int]=[10,100,1000]
// it can guess the data type for array
var arrayC=[10,100,1000]

myArray.insert(10, at: 0)
myArray.insert(111, at: 3)

myArray.last
myArray.first
myArray.count
myArray.shuffle()
myArray.randomElement()
myArray.sort()
myArray.reversed()

myArray.contains(32)
myArray.firstIndex(of: 100)
myArray.lastIndex(of: 100)







