import UIKit


struct MyStructure{
    
    var message = "hello"
    
    func myFunction(){
        print(message)
    }

}


// data type is specific struct
var a: MyStructure = MyStructure()

print(a.message)
a.myFunction()

var b = MyStructure()
b.message="good"
print(b.message)

struct DatabaseManager{
    func saveData(data: String) -> Bool {
        return true
    }
}



struct ChatView{
    
    var message = "hello"
    
    func sendChat(){
        var db = DatabaseManager()
        let if_success = db.saveData(data: message)
        
    }

}
