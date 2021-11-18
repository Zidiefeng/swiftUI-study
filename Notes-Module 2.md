# SwiftUI-CWC-M2

Created: October 16, 2021 7:15 PM
修改时间: November 4, 2021 10:39 PM
完成: No
来源: CWC

### Array

- Swift has three collection types: Arrays, Dictionaries and Sets.
- An array is ideal for data where order matters.
- stores data of single type
- new instance example: `[Int]()`
- index starting from 0
- other functions
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled.png)
    

### List

- It's a SwiftUI view that arranges its sub-views into a scrollable list of elements on screen.
- list of element
    
    ```swift
    struct ContentView: View {
        var body: some View {
            List{
                Text("Element 1")
                Text("Element 2")
                Text("Element 3")
            }
        }
    }
    ```
    
- turn it to list comprehension
    - python: `{text(i) for i in [a,b,c]}`
    - swiftUI: `List([a,b,c], id: itself){i in text(i)}`
        - `List{i in text(i)}` means `List{text(a), text(b), text(c)}`
        - `List(collection, id)` tells what form of the element in collection should be used
        - `\.self` is telling us the format of element to use is just the element itself
    
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        var array = ["Element 1","Element 2","Element 3","Element 4"]
    
        var body: some View {
            List(array, id: \.self){
                arrayElement in
                Text(arrayElement)
            }
        }
    }
    ```
    

### Navigation View

- add a navigationview
    - things inside navigation view assume there is a navigation bar at the top
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%201.png)
    
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        
        var array = ["Element 1","Element 2","Element 3","Element 4"]
    
        var body: some View {
            NavigationView{
                List(array, id: \.self){
                    arrayElement in
                    Text(arrayElement)
                }
            }
        }
    }
    ```
    
- apply a navigation title
    
    <aside>
    💡 **use `navigationBarTitle` to decorate to the first view/element inside the navigation bar instead of the entire navigationView**
    
    </aside>
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%202.png)
    
    ```swift
    struct ContentView: View {
        
        var array = ["Element 1","Element 2","Element 3","Element 4"]
    
        var body: some View {
            NavigationView{
                List(array, id: \.self){
                    arrayElement in
                    Text(arrayElement)
                }.navigationBarTitle(Text("My List"))
            }
        }
    }
    ```
    
- `NavigationLink`: navigate to another view that can be referred back
    - destination: where (what view) to navigate
    - label: what to be clicked on for navigation
    
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        
        var array = ["Element 1","Element 2","Element 3","Element 4"]
    
        var body: some View {
            NavigationView{
                List(array, id: \.self){arrayElement in
                    NavigationLink(destination: Text("Destination"), label:{
                        Text(arrayElement)
                    })
                }.navigationBarTitle(Text("My List"))
            }
        }
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%203.png)
    

### For loop

will repeat for a finite number of times

```swift
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
```

### While

difference is

- The While loop checks the condition before executing the code.
- The Repeat-While loop executes the code and then checks the condition to see if it should repeat. Therefore the Repeat-While loop is guaranteed to execute at least once.
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%204.png)
    

### Class

- class is very alike struct:
    - class has properties and methods
    - class need to be instantiate as instance or object for use
    
    ```swift
    // def a class
    class Person{
        var name = ""
        func talk(){       
        }
    }
    
    // instantiate a class
    var a = Person()
    ```
    
- inherence (subclass)
    - the child class can only inherit from one single parent class
    - inherit the properties and methods of the parent class
        
        ```swift
        // parent class
        class Person{
            var name = ""
            func talk(){
                print("talk")
            }
        }
        
        // child class
        class Comedian: Person {
        }
        
        // inherited properties and methods of Person
        var com = Comedian()
        com.talk()
        //printed "talk"
        ```
        
    - child class can override the parent's method by `override`
        
        ```swift
        class Comedian: Person {
            override func talk() {
                print("make laugh")
            }
        }
        var com = Comedian()
        com.talk()
        // printed "make laugh" 
        ```
        
    - child class can parent's method using `super`
        
        ```swift
        class Comedian: Person {
            override func talk() {
                print("make laugh")
                super.talk()
            }
        }
        var com = Comedian()
        com.talk()
        // make laugh
        // talk
        ```
        
- subclass is only available for `class` , not extendable to `struct`
    - cannot subclass `struct` from `class` (Person)
    - instead, `struct` should be attached to `protocol`
    - for example `View`  in `struct ContentView: View{}` is protocol
        - `View` is not `struct`
        - `View` is not `class`
        - in order to conform to the `View` protocol, `ContentView` must follow some specific rules
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%205.png)
        
    - the parent is called `superclass`
        
        the child is called `subclass`
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%206.png)
        
- class can conform certain protocol
    
    ```swift
    class Comedian: View {
    }
    ```
    
- class can conform to a parent and meanwhile a protocol
    
    ```swift
    class Comedian: Person, View{
    }
    ```
    
- Use `final` to stop a class from being subclassed
    - Comedian cannot be parent class for other subclasses
    
    ```swift
    final class Comedian: Person{
    }
    ```
    

### Value Type Vs Reference Type

<aside>
💡 A structure is a value type and a class is a reference type
Value types are passed as copies and reference types are passed by reference

</aside>

- 2 types of data type
    - struct: value type
    - class: reference type
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%207.png)
    
- Value Type
    - whenever pass to function, or assign to another variable, the value type data is **copied** to another variable
        - for example, in `struct` `b=a` , `a` is copied to `b`, and `a` and `b` is a separate instance
            
            ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%208.png)
            
        - when passing `struct` to function
            1. the type of `TalkShowHost` is `struct`
            2. when passing into `changeName` , the function copied the input parameter into a temporary **constant** parameter `stct` 
            3. the constant `strct` cannot be mutated
            
            ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%209.png)
            
            1. however, if we assign it to a variable instead of using the constant parameter, it works
            
            ```swift
            func changeName(stct: TalkShowHost){
                var tmp = stct
                stct.name = "B"
            }
            ```
            
- Reference Type
    - whenever pass to function, or assign to another variable, the reference type data is **referred/pointed to** to the same object
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2010.png)
        
    - for example, `bb = aa` makes `bb` point to the object to which `aa` is pointing
    - therefore, the following `aa` and `bb` are modifying the same object
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2011.png)
        
    - in function, the local parameter is pointing to the same object as the input parameter
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2012.png)
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2013.png)
        
- when to use `struct` and when to use `class`
    - `class` need more memory than `struct` since it is more dynamic while `struct` is more stable
    - all views are struct, when UI needs to be updated, it throws away all the old view instances and created new ones
    - if need to point to a single instance, probably `class` is better
    - if need multiple copies of instances, use `struct`
    - use `struct` if unsure
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2014.png)
    

### MVVM

- mvvm
    - Model: represents the data
    - ViewModel: business logic and state
        - usually use `class` to avoid multiple copies of instances
        - data that should be accessed in multiple views should be contained in `ViewModel`
    - View: handle UI that users see
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2015.png)
    
- roles
    - The Model is implemented via structs or classes and is used to model after the data in your app. You'll be creating instances of these models to pass around in your app as data.
    - The ViewModel supports the view(s) with data and methods for processing business logic.
    - Data and methods needed by multiple Views should be moved to the ViewModel for reusability.
- Project structure
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2016.png)
    

### Project example of MVVM

- small tip:
    - `Recipe(name: "Spaghetti", cuisine: "Italian")` without init written in `struct`
    
    ```swift
    // def struct
    struct Recipe{
        var name = ""
        var cuisine = ""
    }
    
    // create an instance
    var recipe = Recipe()
    recipe.name= "Spaghetti"
    recipe.cuisine="Italian"
    
    // create an instance (although there is no `init`, but it automatically has one for you!)
    Recipe(name: "Spaghetti", cuisine: "Italian")
    ```
    
- Project structures
    - create new groups `Models` , `ViewModels` , and `Views`
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2017.png)
    
- RecipeModel : ViewModel
    - define class to get data
    
    ```swift
    import Foundation
    
    class RecipeModel{
        var recipes = [Recipe]()
        init(){
            recipes.append(Recipe(name: "Spaghetti", cuisine: "Italian"))
            recipes.append(Recipe(name: "Sushi", cuisine: "Japanese"))
            
        }
    }
    ```
    
- Recipe: Model
    - create `struct` that represents recipe
    - to be used in List in View, data structure `Recipe` have to conform protocol `Identifiable`
        - create id property with UUID() for unique identifier
    
    ```swift
    import Foundation
    
    struct Recipe: Identifiable{
        var id = UUID()
        var name = ""
        var cuisine = ""
    }
    ```
    
- ContentView: View
    - instantiate ViewModel to get data and display data
    
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        
        // this run init and got the data for the 2 recipes
        var model = RecipeModel()
        
        var body: some View {
            List(model.recipes){ r in
                VStack{
                    Text(r.name)
                    Text(r.cuisine)
                }
                
            }
        }
    }
    ```
    
- main app
    - call `ContentView()`
    
    ```swift
    import SwiftUI
    
    @main
    struct lesson7_mvvmApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
    ```
    

### Update the MVVM project to update view automatically

- Listen to changes and update views in real time
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2018.png)
    
- ContentView: View
    - change:
        - add a button to append recipe in `model.recipes`
        - when create `model` , using `@ObservedObject` to decorate to listen to changes of `model` and update view
            - Inside the View, by marking the ViewModel (ObservableObject) with the ObservedObject property wrapper, you indicate that we want to listen for any published changes from that object.
    
    ```swift
    import SwiftUI
    
    struct ContentView: View {
        
        // this run init and got the data for the 2 recipes
        @ObservedObject var model = RecipeModel()
        
        var body: some View {
            
            VStack {
                List(model.recipes){ r in
                    VStack{
                        Text(r.name)
                        Text(r.cuisine)
                    }
                }
                Button("Add Recipe"){model.addRecipe()}
            }
            
        }
    }
    ```
    
- RecipeModel : ViewModel
    - changes
        - use `@Published` to decorate to the var that broadcast changes to views that observing this class object
            - In order for the View to detect data changes in the properties of the ViewModel, the ViewModel must mark its properties with the @Published keyword.
        - use `ObservableObject` as protocol of the `ViewModel`
            - The ViewModel conforms to the ObservableObject protocol so that the View can "observe" it and pick up any data changes on its properties marked with @Published.
    
    ```swift
    import Foundation
    
    class RecipeModel: ObservableObject{
        @Published var recipes = [Recipe]()
        init(){
            recipes.append(Recipe(name: "Spaghetti", cuisine: "Italian"))
            recipes.append(Recipe(name: "Sushi", cuisine: "Japanese"))
        }
        
        func addRecipe(){
            recipes.append(Recipe(name: "Burger", cuisine: "American"))
        }
    }
    ```
    

### Optional

- properties and variables have always been declared with initial value, while sometimes we may have empty value, especially for:
    - data from data feed or API (maybe no data returned)
- Every time we access to a variable, we expect value back
- declaration
    - original
        
        ```swift
        var a = 1
        var x = 1 + a
        ```
        
    - not working, not initial value assigned
        
        ```swift
        var a //error 'type annotation missing in pattern', have to set value in declaration
        var x = 1 + a // error
        ```
        
    - state of empty or nothing: `nil`
    - cannot assign `nil` directly to a variable (swift is protecting it)
        
        ```swift
        var a = nil //error
        ```
        
- to declare var that can contain `nil` , we need to use `optional`
    - there are 2 types of `optional`
        1. implicitly unwrapped optional using `!` 
            - `var b:Int!` turns `b` into optional and can be assigned to `nil` . Here, no initial value need to be assigned
            - `var b:Int! = nil`
            - `var x = 1+b` would be an error since `b` is `nil` right now. this could crash the app
            - however, no compiler error will show in advance for `var x = 1+b` in the editor
            - to avoid this mistake, we can use something like. However, this relies on programmers to remember `b` might be `nil`
                
                ```swift
                if b != nil{
                		var x = 1+b
                }
                ```
                
        2. (regular) optional using `?`
            
            <aside>
            💡 为了避免让coder自己记是否需要考虑 `nil` 的情况，使用optional符号 `?` declare的变量在取值时，无论是否真的是 `nil`，都要使用 `!` 来unwrap。在编译器中，没有使用 `!` 就会报错，而是用了 `!` 也可以浅显地提醒coder需要特殊处理这个可能是 `nil` 的变量。
            
            </aside>
            
            - `var c:Int?` set the default value as `nil`
            - `var x = 1+c` this is showing a compiler error in advance in the editor
            - to get the value of regular optional, we need to unwrap it using `!`, no matter whether it is value or `nil`
                
                ```swift
                var x = 1 + b!
                ```
                
            - what is unwrap
                - view it as a present that can be a gift or nothing. The actual results are shown only when you unwrap this present
            - `var c:Int? = 10` optional var can be assigned to value
            - we can handle optional easily since it's labeled in the editor
                
                ```swift
                lif c!= nil{
                	var x = 1 + c!
                }
                ```
                
- Comparison of `!` and `?`
    - implicitly unwrapped optional `!`
        - no need to unwrap to get the value
        - Xcode doesn't warn us
        - Can contain `nil`
    - regular optional `?`
        - need to unwrap to get the value
        - Xcode warns us
        - Can contain `nil`
        - a regular choice for optional
- optional binding
    - original condition check
        - use condition `if c != nil` to check optional var first
        - unwrap optional every time to use it
    - optional binding
        - use assignment condition `let y = c`
            1. if c is `nil` , this condition returns `false`
            2. if c is value, this condition returns `true`
            3. `c` is assigned to `y`
            4. no need to unwrap `c` (optional) — use `y` instead!
        
        ```swift
        // original
        if c != nil {
            var x = 1+c!
        }
        
        // optional binding
        if let y = c{
            var x1 = 1 + y
        		var x2 = 2 + y
        }
        ```
        
- optional chaining for `struct` and `class`
    - `var p: Person? = nil` optional `struct` or `class`
    - optional chaining:
        - if `struct` or `class` is `nil` , no execution
        - if `struct` or `class` is not `nil` , call the function / get the property
        
        ```swift
        p?.name  // access to optional's property
        p?.talk() //access to optional's method
        ```
        
        ```swift
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
        ```
        
    - can fix this automatically in Xcode
- when to use optional
    - no default value
    - unset state
    - refer to data that can be nil (from API or data feed)
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2019.png)
    
- summary
    - `nil` : nothing
    - optional can contain `nil`
    - unwrap an optional to get value
    - condition check/preparation for optional
        - if statement
        - optional binding
        - optional chaining (for method and properties)
    - implicitly unwrapped optional is an optional that is already unwrapped.
    - no protection provided in Xcode for implicitly unwrapped optionals
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2020.png)
    

### Dictionary

- key-value pair
- difference between array and dictionary:
    - array: order matters
    - dictionary: order is not guaranteed
- loop through dictionary
    - each item is a key-value pair instead of key!
    - can loop through dictionary using `tuple`
- data type can be referred
- the value part is `optional` since it can be `nil` when the value for a key does not exist

```swift
// empty dict
var a:[String:String] = [String:String]()

// infer data type
var b = [String:String]()

// use Any to represent any data type (dangerous)
var c = [String:Any]()

// add key-value pair
a["txp503"] = "KK K" //Optional("KK K")

// retrieve value by key
print(a["txp503"])

// retrieve by key that does not exist
print(a["dsa"]) // nil

// update key-value pair
a["txp503"] = "kkkk kkkk"

// remove key value pair
a["txp503"] = nil

print(a["txp503"])

// deplare dictionary with intial key-value pairs
var d = ["ejf978":"Apple", "asd102":"Leen"]

// Iterating through a dictionary
for pair in d{
    print("key is: " + pair.key)
    print("value is: " + pair.value)
}

// Iterating through a dictionary
for (key, value) in d{
    print("key is: " + key)
    print("value is: " + value)
}

// Iterating through a dictionary
for (key, value) in d{
    print("key is: " + key)
    print("value is: " + value)
}

// tuple
var e:(String, String) = ("sad131", "anee")
print(e.0)
print(e.1)
```

### JSON

- json can be transformed to model `struct` or `class` in SwiftUI
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2021.png)
    
- 3 symbols in JSON
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2022.png)
    
    - JSON Object
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2023.png)
        
    - JSON Array
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2024.png)
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2025.png)
        
- JSON file is just like txt file but end with `.json`
- example
    - create a json file in `Data` folder in the mvvm demo
        
        ```json
        [{
                "name": "Spaghetti",
                "cusine": "Italian"
            },
            {
                "name": "Sushi",
                "cusine": "Japanese"
            },
            {
                "name": "Burger",
                "cusine": "American"
            }
        ]
        ```
        
    - fill in content
    - check if the json format is valid in some website:
        
        [The JSON Validator](https://jsonlint.com/)
        

### Parse JSON

- delete original data starting code
    
    from
    
    ```swift
    import Foundation
    
    class RecipeModel: ObservableObject{
        @Published var recipes = [Recipe]()
        init(){
            recipes.append(Recipe(name: "Spaghetti", cuisine: "Italian"))
            recipes.append(Recipe(name: "Sushi", cuisine: "Japanese"))
        }
        
        func addRecipe(){
            recipes.append(Recipe(name: "Burger", cuisine: "American"))
        }
    }
    ```
    
    to
    
    ```swift
    import Foundation
    
    class RecipeModel: ObservableObject{
        @Published var recipes = [Recipe]()
        init(){
    
        }
        
        func addRecipe(){
        }
    }
    ```
    
- the local json files and images will be packed up in the bundle as well
    - `data/data.json`
        
        ```swift
        [{
                "name": "Spaghetti",
                "cusine": "Italian"
            },
            {
                "name": "Sushi",
                "cusine": "Japanese"
            },
            {
                "name": "Burger",
                "cusine": "American"
            }
        ]
        ```
        
    - `Models/Recipe.swift`
        
        ```swift
        import Foundation
        
        struct Recipe: Identifiable{
            var id = UUID()
            var name = ""
            var cuisine = ""
        }
        ```
        
- Turn `data/data.json` to Recipe object ( `Models/Recipe.swift` )
    - Recipe.swift
        - use `Decodable` protocol to be decodable by decoder
            - In order to use the JSONDecoder class to convert the JSON data into instances of the model structs/classes, they have to conform to the Decodable protocol. They only need an "id" property if you will display them in a SwiftUI List.
        - turn `id` to optional since it's created later using UUID()
        - turn `struct` to `class` (if using `struct` , the `id` property cannot be changed)
        
        ```swift
        import Foundation
        //use Decodable protocol to be decodable by decoder
        class Recipe: Identifiable, Decodable{
            var id:UUID?
            var name = ""
            var cuisine = ""
        }
        ```
        
    - RecipeModel.swift
        - get json file path
        - package the path into url
        - load data from url
            - Get a url to the local JSON file. Then pass the url into the Data object. The Data object will fetch the data at the url.
        - decode the data to certain swift object
        - remember to set id for the mapped model from json (if `id` is not provided, `List` cannot tell items apart)
        - if no id is provided in the json data file, create the id using UUID
        - remember to handle the potential error and optional
        
        ```swift
        import Foundation
        
        class RecipeModel: ObservableObject{
            @Published var recipes = [Recipe]()
            init(){
                // get the path to json file (within the app bundle)
                // Bundle.main represents the app bundle
                // if cannot find, it returns `nil`
                let pathString = Bundle.main.path(forResource: "data", ofType: "json") // fileName, fileType
                if let path = pathString {
                    // Create a url object
                    let url = URL(fileURLWithPath: path)
                    
                    
                    // Error handling
                    do {
                        // Put the code that potentially thros an error
                        
                        // Create a data object with the data at the url
                        let data = try Data(contentsOf: url)
                    
                        // Parse the data
                        let decoder = JSONDecoder()
                        do{
                            //as a parameter, need .self
                            let recipeData = try decoder.decode([Recipe].self, from: data)
                            
                            // set unique IDs for each instance
                            for r in recipeData{
                                
                                //set unique ID for each recipe in the recipeData array
                                r.id = UUID()
                            }
                            
                            
                            self.recipes = recipeData
                        } catch {
                            print(error)
                        }
                    } catch {
                        // Execute if an error is thrown
                        // Handle the error
                        print(error)
                    }
                    
                    
                }
            }
            
            func addRecipe(){
            }
        }
        ```
        
- if no id, the array cannot tell things apart
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2026.png)
    

### Recipe App

- structure of app
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2027.png)
    
- copy data json file to app
    - should copy items
    - `add to targets` means to be included in the app bundle
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2028.png)
        
- Create new swift files
    - make sure `recipe list app` is checked to be included in the bundle
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2029.png)
        
    - double check on the right bar: `recipe list app` should be checked
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2030.png)
        
- rename view
    - control+item
    - may need manually rename
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2031.png)
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2032.png)
    
- Code
    - Views/RecipeListView
        - Create observed model using ViewModel
        - List items
        
        ```swift
        import SwiftUI
        
        struct RecipeListView: View {
            
            // Reference to the view model
            @ObservedObject var model = RecipeModel()
            
            
            var body: some View {
                List(model.recipes){r in
                    HStack(alignment: .center, spacing: 20.0){
                        Image(r.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50,
                                   height: 50,
                                   alignment: .center)
                            .clipped()
                            .cornerRadius(5)
        
                        Text(r.name)
                    }
                }
                
            }
        }
        ```
        
    - ViewModels/RecipeModel
        - create properties that contains data
        - call service to load initial data
        
        ```swift
        import Foundation
        
        class RecipeModel: ObservableObject{
            @Published var recipes = [Recipe]()
            
            init(){
                // Parse the json file
        //        let service = DataService()
        //        self.recipes = service.getLocalData()
                
                // when using `static`, the function of a class can be directlly called without instance
                self.recipes = DataService.getLocalData()
                
                
                // set the recipes property
            }
            
        }
        ```
        
    - Models/Recipe
        - class to mimic data object (local json file in this case)
        
        ```swift
        import Foundation
        
        class Recipe: Identifiable, Decodable {
            
            var id: UUID?
            var name: String
            var featured: Bool
            var image: String
            var description: String
            var prepTime: String
            var cookTime: String
            var totalTime: String
            var servings: Int
            var ingredients: [String]
            var directions: [String]
        
        }
        ```
        
    - Services/DataService
        - function to actually load data
        - Remember to `return [Recipe]()` when things go wrong
        - use `static` to call function directly
            - The static keyword allows you to call the method on the class itself rather than having to create an instance of it and then calling it on the instance. This can be handy when you just need the method for utility and there's no need to have instances to perform any additional work.
        
        ```swift
        import Foundation
        
        class DataService{
            static func getLocalData() -> [Recipe]{
                // Parse local json file
                
                // get url path
                let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
                
                // check if pathString is not nill, otherwise ...
                guard pathString != nil else{
                    return [Recipe]()
                }
                
                
                // create url
                let url = URL(fileURLWithPath: pathString!)
                
                // create data object
                do{
                    let data = try Data(contentsOf: url)
                    
                    // decode the data
                    let decoder = JSONDecoder()
                    do{
                        let recipeData = try decoder.decode([Recipe].self, from: data)
                        
                        // add unique ID
                        for r in recipeData{
                            r.id = UUID()
                        }
                        return recipeData
                        
                    } catch{
                        // error with parsing data
                        print(error)
                    }
                    
                    
                    
                    // return recipes
                } catch{
                    // error with getting data
                    print(error)
                }
                
                // return empty data if data is not available
                return [Recipe]()
        
            }
        }
        ```
        

### Debug

- set break point and run line by line
    - can type `po` and item to print object
    - `stepover` to run line by line
    - check the variables and value
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2033.png)
    

### Loop in view

- Effect that we want to perform
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2034.png)
    
- cannot use loop in view
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2035.png)
    
- Loop specially for generating UI elements: `ForEach`
    
    <aside>
    💡 The ForEach loop can be used in your view code to dynamically generate UI elements. Any view code inside the ForEach loop will be repeated for each iteration of the loop.
    
    </aside>
    
    - like putting things in a list, but not a list
    - just iterating
    - need id in iterable things (use `\.self`  to represent the id)
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2036.png)
    
- In `body` , there is only one root element
    - the following code only show once (only one root element)
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2037.png)
    

### ScrollView

- `ScrollView` is a container that scrolls
    - The ScrollView is a container allows you to put views into a scrollable pane.
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2038.png)
    
- **Why would you want to use a ScrollView with a ForEach loop inside of it instead of a List?**
    - You'd want to use the ScrollView and ForEach combo when you want finer control over how the list of elements look.
    - At least for now, the SwiftUI List has some elements which are difficult to style. For example, the lines in-between each element. Sometimes, you might want to use the ScrollView / ForEach combo to display a scrollable list of items styled the way you want.

### different format

- `0...2`
    
    ```swift
    ScrollView{
        ForEach(0...2, id: \.self){i in
            Text(String(i) + " " + array[i])
        }
    }
    ```
    
- `0...array.count-1`
    
    ```swift
    ScrollView{
        ForEach(0...array.count-1, id: \.self){i in
            Text(String(i) + " " + array[i])
        }
    }
    ```
    
- `0..<array.count`
    
    ```swift
    ScrollView{
        ForEach(0..<array.count, id: \.self){i in
            Text(String(i) + " " + array[i])
        }
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2039.png)
    
- practice
    - put ForEach in Vstack first and then put into ScrollView
        
        ![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2040.png)
        
    

Project example - detailed view

![Untitled](SwiftUI-CWC-M2%20f42ed323a78044b7a63b111b8c6557c0/Untitled%2041.png)

**How do you create a re-useable view in your app?**

Add a new SwiftUI View to your Xcode project. Give this view struct a name. Now you can create instances of this new view in the view code where you want to display it.

In the Recipe List app, we created a new Recipe Detail View by adding a new SwiftUI View file to our project. After that, we were able to display this new view by creating a new instance of it in the view code.

### Insert dot

- search unicode dot
    
    [Unicode](https://www.compart.com/en/unicode/U+2022)
    
- copy and use it
    
    `Text("• "+item)`