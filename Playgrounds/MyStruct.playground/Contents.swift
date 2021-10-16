//struct MyStruct{
//    // variables & constants to track data related to this structure
//
//    // functions related to this structure
//}

struct ChatView{
    //property
    var message1: String = "hi"
    
    // direct assignment may not need data type specification
    var message2 = ""
    
    // var with computation need data type pre-specified
    var messageWithPrefix : String {
        // can start with return
        return "He said: " + message1
    }
    
    var messageWithPrefix1 : String {
        // no need to use `return` for single line
        "He said: " + message1
    }
    
    var messageWithPrefix2 : String {
        // must use `return` for single line
        let message3 = "3"
        return "He said: " + message3
    }
    
    
    
    // View Code for this screen
    
    // methods
    func sendChat(){
        //Code to send the chat message
        print(messageWithPrefix)
    }
}
