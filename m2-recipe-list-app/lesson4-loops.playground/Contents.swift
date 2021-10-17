// Immutable value 'index' was never used; consider replacing with '_' or removing it
for index in 1...10{
    print("Hello")
}

// use _ , no warnings
for _ in 1...10{
    print("Hello")
}

//use "\(variable)"
for num in 1...10{
    print("Hi \(num)")
}

// for i in 0...array.count-1
var array = [1,5,10]
for i in 0...array.count-1{
    print(array[i])
}


for element in array{
    print(element)
}
