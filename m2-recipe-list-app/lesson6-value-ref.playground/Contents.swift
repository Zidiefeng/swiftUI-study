
class Person{
    var name = ""
    func talk(){
        print("talk")
    }
}
var per1 = Person()

class Comedian: Person {
    override func talk() {
        print("make laugh")
        
        super.talk()
    }
}
var com = Comedian()
com.talk()


//
//class Comedian: View {
//}

//class Comedian: Person, View{
//}




struct TalkShowHost{
    var name=""
}

var a = TalkShowHost()
a.name="A"

print(a.name)
print(a)


a.name = "B"
print(a.name)
print(a)


var b = a
b.name="BBBB"
print(b.name)

func changeNum(a:Int) -> Int{
    return a+3
}

func myFunc3(a:Int) -> Int{
    let b = 20
    print(a+b)
    return a+b
}

changeNum(a: 3)


//func changeName(stct: TalkShowHost){
//    stct.name = "B"
//}


func changeName(stct: TalkShowHost){
    var tmp = stct
    tmp.name = "B"
}


var aa = Comedian()
aa.name="Chris"

var bb = aa
bb.name = "David"
print(aa.name)
print(bb.name)

func changeName(p:Comedian){
    p.name="SS"
}
changeName(p: aa)
print(aa.name)
