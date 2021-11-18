# SwiftUI-CWC-M1

Created: October 14, 2021 2:04 PM
修改时间: October 30, 2021 5:28 PM
完成: No
来源: CWC

[https://www.youtube.com/watch?v=F2ojC6TNwws](https://www.youtube.com/watch?v=F2ojC6TNwws)

[2021 SwiftUI Tutorial for Beginners (3.5 hour Masterclass)](https://www.youtube.com/watch?v=F2ojC6TNwws)

[14 Day Beginner Challenge](https://www.dropbox.com/sh/7aopencivoiegz4/AACy5lKSPRPTGAVHXaoeYk7ea?dl=0)

### Basics

- Swift related tools
    - Xcode: build app, build interface, connect with data
    - Swift: come
    - SwfitUI: UI framework
- Coverage
    - iOS
    - iPadOS
    - tvOS
    - watchOS
    - macOS
- Distribution: App Store
    - requirement: enroll `apple developer program`
    - benefits:
        - app store connect: app listing, metadata, screenshot, purchases
        - TestFlight: beta test, feedback collection
        - provisioning portal: tools to identify and co-sign of the app (identify who built it)
    - submit to app store connect for review
        - follow review guideline
        - you can re-submit
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled.png)
    

### Xcode

- Need space for Xcode 30GB
- Check the requirement information about compatibility like macOS 10.15.4 or later

### New iOS project

- file - new - project
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%201.png)
    
- boundle: product name + org id
    - example: `com.ks.mytest`
    - used for: unique app id in app store
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%202.png)
    
- set preference
    - Xcode -> Preferences -> General -> File Extensions -> Show all
- View code structure - turn on small map
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%203.png)
    
- search library `+` and drag component and modifiers to the code
    - component: directly drag
    - modifier: drag to the end of the code
- canvas
    - turn on canvas to see preview of a certain page (refresh preview automatically)
    - `command` + click component in the canvas
        
        ```swift
        import SwiftUI
        
        struct ContentView: View {
            var body: some View {
                Text("Placeholder")
                    .padding([.top, .leading, .bottom])
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.pink
                                                                                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)/*@END_MENU_TOKEN@*/).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        //        Text("hi").padding().background(Color.yellow)
            }
        }
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
        ```
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%204.png)
        
        - Click `show swiftUI inspector` and specify modifiers
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%205.png)
        
    - command + code component:
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%206.png)
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%207.png)
        

### image+stack

- upload image
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%208.png)
    
- vstack (vertical stack)
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%209.png)
    
- hstack
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2010.png)
    
- Zstack:
    - front and back
    - the latter one sits on the top of the prior one
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2011.png)
    
- shortcut to embed an component in stack
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2012.png)
    
- on the inspector, you can do alignment, spacingv
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2013.png)
    
- `Spacer()`
    - can help equally occupy space in a certain `HStack` or `VStack`
    - If there is only one `Spacer()` between 2 items, A and B, it pushes A and B both to their boundaries
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2014.png)
        
- safe area
    - ignore the safe area to stretch the green background
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2015.png)
        
        ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2016.png)
        

### Example

- code
    
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        var body: some View {
            ZStack {
                Image("background")
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Image("logo")
                    Spacer()
                    HStack{
                        Spacer()
                        Image("card3")
                        Spacer()
                        Image("card4")
                        Spacer()
                    }
                    Spacer()
                    Image("logo")
                    Spacer()
                    HStack{
                        Spacer()
                        VStack(alignment: .center, spacing: 20.0){
                            Text("Player")
                                .foregroundColor(Color.white)
                            Text("0")
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                        VStack(alignment: .center, spacing: 20.0){
                            Text("Player")
                                .foregroundColor(Color.white)
                            Text("0")
                                .foregroundColor(Color.white)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    ```
    
- result
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2017.png)
    

### Playground

- playground: light way of code development (not a full app)
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2018.png)
    
- turn on debug box at the bottom
- can run selection code or all code
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2019.png)
    

## Data

![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2020.png)

### Var & Constant

- data type:
    - Int
    - String
    - Double
    - Bool
- use constant over var if appropriate
    
    `var myVar: String = "hello"`
    
    ```swift
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
    ```
    

### Function

```swift
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
```

## Structure

- `struct` start with capital letter
- Struct as a screen in an app
- Struct as a data manager, as a component in an app

![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2021.png)

### Structure of `struct`

1. variables, constants
2. functions

```swift
struct MyStruct{
    // variables & constants to track data related to this structure
    
    // functions related to this structure
}
```

### Scope of `struct`

- Scope of struct `ChatView` is everything within `{}`
- Properties in the struct scope can be accessed by this struct's methods
- method have local scope and variable/constant in the local scope is not accessible by the outside struct scope
    
    ```swift
    struct ChatView{
        //property
        var message: String = ""
        
        // View Code for this screen
        
        // methods
        func sendChat(){
            //Code to send the chat message
            print(message)
        }
    }
    ```
    

### Properties in `struct`

- direct assignment: no data type specification required
- computed properties
    - data type specification is required
    - use return in the code block for multiple lines

```swift
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
```

### instruct

- instruct is really like a class
- instruct is just an template
- instruct should be initiated as instance to use
    - instruct as customized data type: `var a: MyStructure = MyStructure()`
    - `a.func()` to call method
    - `a.message` to call property
    - `instruct` can be initialized as instance in another `instruct`
    
    ```swift
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
        func saveData(data:String) -> Bool{
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
    ```
    

### `private`

- Properties and methods in a `instruct` can be private (only accessible within the `instruct` scope)
    
    ```swift
    struct DatabaseManager{
    		private server = ""
        private func saveData(data:String) -> Bool{
            return true
        }
    }
    ```
    
    Now `.server` and `.saveData()` of an instance cannot be accessed 
    

<aside>
💡 Collapse certain code: `option` + `cmd` + `←`

</aside>

### View

- View is not the data type
- In `instruct` the name itself is the data type
- `View` in `struct ContentView: View {}` means this instruct follows protocol `View`
    - protocol: set of rules, actions, specifications to be follow
    - Things inside `{}` conform to this protocol
- Text is a pre-defined instruct: `Text("Hello, world")`
- `Text("Hello, world!").padding()` is calling its method

### Open developer documentation

- right bottom
    
    ![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2022.png)
    
- dev doc中的relationship可以看到protocol

### Instance for the view

- instance and preview
    - you can set the config in interface
    
    ```swift
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    ```
    
- instance in app
    
    ```swift
    @main
    struct testProjectApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
    ```
    

### Button

- action: code to run when button is clicked
    
    ```swift
    Button("Click Me", action: () -> Void)
    ```
    
- example
    
    ```swift
    Button("Click Me", action: {
                print("hello world")
            })
    ```
    
- use a different format (trailing closure)
    
    these two are the same
    
    ```swift
    // Button instance with closure
    Button("Click Me", action: {
        print("hello world")
    })
    
    // Button instance with trailing closure
    Button("Click Me"){
        print("hello world")
    }
    ```
    
- button
    - use label to change the button display
    - since action is no longer the last argument, trailing closure is not available
    - the default icon is available, for example `Image(systemName: "pencil")`
    
    ```swift
    // Button instance with label view
    Button(action:{
        print("Hello world")
    },label:{
        HStack{
            Image(systemName: "pencil")
            Text("Button")
        }
    })
    ```
    

### Property Wrapper: `State`

- because of memory treatment, default property cannot be changed in button action
- instance's property cannot be changed
- using `@state` in property
    - can change the value in the instance
    - inside view code, anything references to `@state` properties will get notified when the data changed, and UI will change automatically based on the data
- example
    
    ```swift
    struct ContentView: View {
        @State var playerCard = "vard5"
        @State var cpuCard = "card9"
        @State var playerScore = 0
        @State var cpuScore = 0
        
        var body: some View {
            ZStack {
                Image("background")
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    Image("logo")
                    Spacer()
                    HStack{
                        Spacer()
                        Image(playerCard)
                        Spacer()
                        Image(cpuCard)
                        Spacer()
                    }
                    Spacer()
                    // Image("logo")
                    Button {
                        // update the cards
                        
                        // cannot change the property directly, error
                        let playerRand = Int.random(in: 2...14)
                        let cpuRand = Int.random(in: 2...14)
                        
                        // instead, need a property wrapper, @State
                        playerCard="card"+String(playerRand)
                        cpuCard="card"+String(cpuRand)
                        
                        // update the score
                        if playerRand > cpuRand{
                            playerScore+=1
                        }else{
                            cpuScore+=1
                        }
        
                    } label: {
                        Image("dealbutton")
                    }
    
                    
                    Spacer()
                    HStack{
                        Spacer()
                        VStack(alignment: .center, spacing: 20.0){
                            Text("Player")
                                .foregroundColor(Color.white)
                            Text(String(playerScore))
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                        VStack(alignment: .center, spacing: 20.0){
                            Text("Player")
                                .foregroundColor(Color.white)
                            Text(String(cpuScore))
                                .foregroundColor(Color.white)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    ```
    

### Lifecycle

![Untitled](SwiftUI-CWC-M1%209f44d31215e64b8a8c3690c373be2280/Untitled%2023.png)