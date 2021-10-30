// sometimes we don't want to declare with value
// express empty

var a = 1

var x = 1+a

// every time we access to a variable, its value back
// sometimes we need variable that has nothing or unset


// error, (swift is trying to protect it)
// var a = nil


// declare var that can contain nothing, use optional
var b : Int! = nil

// the following shows the same thing
var c: Int!

if b != nil {
    // now its rely on programmer's memory about whether it's optional
    var x = 1 + b
}

// safer way: implicitly unwrapped optional

// optional, can contain value or nil
var d:Int?
var e: Int? = 10

// error, since d can be nil
//var y = d + 1


// present: gift or nothing

//error
//var x = 1+ d!
if c != nil {
    var x = 1+c!
}



// optional binding
if let y = c{
    var x = 1 + y
}

struct Person {
    var name = "K"
    func talk(){
        print("hello")
    }
}

var p: Person? = nil
p!.talk() // this crashed since p is `nil`
p?.talk() //if p is nil, no execution
          // if p is not nil, execute it

p?.name // the same to property
p?.talk()



