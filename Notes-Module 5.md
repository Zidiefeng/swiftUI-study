# SwiftUI-CWC-M5

Created: November 18, 2021 12:33 AM
修改时间: December 6, 2021 7:44 PM
完成: No

### App Structure

- This app has a more complex navigation flow
    - 2 layers of the navigation
    - the lowest view can be back directly to the top view
    - the lesson can be progressed to the next lesson
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled.png)
    
- Use environment object
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%201.png)
    

### App Setup

- Update file name of the main app
    - app name → learningApp
    - ContentView → HomeView
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%202.png)
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%203.png)
    
- build the basic structures
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%204.png)
    
- basic files
    - learningApp.swift
        
        ```swift
        import SwiftUI
        
        @main
        struct learningApp: App {
            var body: some Scene {
                WindowGroup {
                    HomeView()
                        .self.environmentObject(ContentModel())
                }
            }
        }
        ```
        
    - Views/HomeView.swift
        
        ```swift
        import SwiftUI
        
        struct HomeView: View {
            
            @EnvironmentObject var model: ContentModel
            
            var body: some View {
                Text("Hello, world!")
                    .padding()
            }
        }
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                HomeView()
            }
        }
        ```
        
    - ViewModels/ContentModel.swift
        
        ```swift
        import Foundation
        
        class ContentModel: ObservableObject {
            
        }
        ```
        

### Data Description

- resources/data.json
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%205.png)
    

### Read local data

- `Bundle.main.url` returns optional URL
- `Bundle.main.path` returns optional String
- ViewModel/ContentModel.swift
    
    ```swift
    import Foundation
    
    class ContentModel: ObservableObject {
        @Published var modules: [Module] = [Module]()
        
        var styleData : Data?
        
        init() {
            self.getLocalData()
        }
        
        func getLocalData(){
            // Get a url to the json file
            let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
            
            do {
                // Read the file into a data object
                let jsonData = try Data(contentsOf: jsonUrl!)
                
                // Try to decode the json into an array of modules
                let jsonDecoder = JSONDecoder()
                //use `.self` to pass the type
                let modules = try jsonDecoder.decode([Module].self, from: jsonData)
                
                //assign modules to var
                self.modules = modules
            }
            catch{
                // log error
                print("Could not parse local data")
            }
            
            
            // parse the style data
            let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
            
            do{
                let styleData = try Data(contentsOf: styleUrl!)
                
                self.styleData = styleData
            }
            catch{
                // log error
                print("Could not parse style data")
            }
            
            
            
        }
    }
    ```
    

### Check with breakpoint

1. put a breakpoint to the code
2. build the app
3. hit step-over button
4. check var in the console by typing 'po ***'
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%206.png)
    
5. check if data has been loaded correctly
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%207.png)
    

### Create a view template

- **How should you deal with lots of duplicate code in for a view?**
    - Try to extract the code into a reusable subview
- the original code structure
    - `learning card` section has almost the same structure as `Test card` section
    - if writing this way, we can copy the code in  `learning card` section to  `Test card` section; however, this is very redundant
    
    ```swift
    struct HomeView: View {
        
        @EnvironmentObject var model: ContentModel
        
        var body: some View {
            ScrollView{
                LazyVStack{
                    ForEach(model.modules){ module in
                        //-----------Learning card
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                //use fixed ratio instead of fixed size
                                .aspectRatio(CGSize(width: 335, height: 175), contentMode:.fit)
                                //.frame(width: 335, height: 175)
                            
                            HStack{
                                //Image
                                Image(module.content.image)
                                    .resizable()
                                    .frame(width: 116, height: 116)
                                    .clipShape(Circle())
                                
                                Spacer()
                                
                                // Text
                                VStack(alignment: .leading, spacing: 10){
                                    // Headline
                                    Text("Learn \(module.category)")
                                        .bold()
                                    
                                    // Description
                                    Text(module.content.description)
                                        .padding(.bottom,20)
                                        .font(Font.system(size: 10))
                                    
                                    // Icons
                                    HStack{
                                        // # of lessons, questions
                                        Image(systemName: "text.book.closed")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                        Text("\(module.content.lessons.count) Lessons")
                                            .font(.caption)
                                        
                                        Spacer()
                                        
                                        //time
                                        Image(systemName: "clock")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                        Text(module.content.time)
                                            .font(.caption)
                                    }
                                }
                                .padding(.leading,20)
                                
                            }
                            //.padding([.leading,.trailing],20)
                            .padding(.horizontal,20) // this is the same as the prior line
                        }
                        //-----------Test card
                    }
                }
                .padding()
            }
        }
    }
    ```
    
- template view
    - instead, we can create a template view to pass in customized parameters
        
        ```swift
        //
        //  HomeViewRow.swift
        //  m5-learning-app
        //
        //  Created by 孙恺檀 on 11/20/21.
        //
        
        import SwiftUI
        
        struct HomeViewRow: View {
            
            var image: String
            var title: String
            var description: String
            var count: String
            var time: String
            
            var body: some View {
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        //use fixed ratio instead of fixed size
                        .aspectRatio(CGSize(width: 335, height: 175), contentMode:.fit)
                        //.frame(width: 335, height: 175)
                    
                    HStack{
                        //Image
                        //Image(module.content.image)
                        Image(image)
                            .resizable()
                            .frame(width: 116, height: 116)
                            .clipShape(Circle())
                        
                        Spacer()
                        
                        // Text
                        VStack(alignment: .leading, spacing: 10){
                            // Headline
                            //Text("Learn \(module.category)")
                            Text(title)
                                .bold()
                            
                            // Description
                            //Text(module.content.description)
                            Text(description)
                                .padding(.bottom,20)
                                .font(Font.system(size: 10))
                            
                            // Icons
                            HStack{
                                // # of lessons, questions
                                Image(systemName: "text.book.closed")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                //Text("\(module.content.lessons.count) Lessons")
                                Text(count)
                                    .font(.caption)
                                
                                Spacer()
                                
                                //time
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                //Text(module.content.time)
                                Text(time)
                                    .font(.caption)
                            }
                        }
                        .padding(.leading,20)
                        
                    }
                    //.padding([.leading,.trailing],20)
                    .padding(.horizontal,20) // this is the same as the prior line
                }
            }
        }
        
        struct HomeViewRow_Previews: PreviewProvider {
            static var previews: some View {
                HomeViewRow(image: "swift", title: "Learn Swift", description: "some description", count: "10 Lessons", time: "2 Hours")
                
            }
        }
        ```
        
    - to use it
        
        ```swift
        ScrollView{
            LazyVStack{
                ForEach(model.modules){ module in
                    //Learning card
                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
        
                    // Test card
                    HomeViewRow(image: module.test.image, title: "Learn \(module.category)", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
        
                }
            }
            .padding()
        ```
        

### re-indent

![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%208.png)

### **.aspectRatio**

- **What does the modifier do?**
    - It specifies an aspect ratio for a view to maintain respective to screen size
    - Using the aspectRatio modifier can help accommodate different screen sizes, since it will scale the view's dimensions in relation to the screen size.

### How to pass an object to a view

- want to pass in a single module in the module list `modules` to a view
- the original way to pass a single module
    
    ```swift
    struct ContentView: View {
        
        var module: Module
        
        var body: some View {
            ScrollView{
                LazyVStack{
                    ForEach(module.content.lessons){lesson in
                        
                        
                    }
                }
            }
        }
    }
    ```
    
- a better way to pass a single module
    1. define `@Published var currentModule` and function `beginModule()` to set `currentModule` by module id in the view model
        
        ```swift
        class ContentModel: ObservableObject {
            
            // List of modules
            @Published var modules: [Module] = [Module]()
            
            // Current module
            @Published var currentModule: Module?
            var currentModuleIndex = 0
            
            
            var styleData : Data?
            
            init() {
                self.getLocalData()
            }
            
            // MARK: data methods
            func getLocalData(){...}
            
            // MARK: module navigation methods
            func beginModule(_ moduleId:Int){
                
                //Find the index for this module id
                for index in 0..<modules.count{
                    if modules[index].id == moduleId{
                        
                        // find the matching module
                        if modules[index].id == moduleId{
                            currentModuleIndex = index
                            break
                        }
                    }
                }
                
                // Set the current module
                currentModule = modules[currentModuleIndex]
            }
        }
        ```
        
    2. use `model.currentModule!` to access to the current module
        
        ```swift
        struct ContentView: View {
            
            //var module: Module
            @EnvironmentObject var model: ContentModel
            
            var body: some View {
                ScrollView{
                    LazyVStack{
                        
                        // Confirm that currentModule is set
                        if model.currentModule != nil{
                            ForEach(0..<model.currentModule!.content.lessons.count){index in
                                
                                
                                let lesson = model.currentModule!.content.lessons[index]
                                
                                
                                // Lesson card
                                ZStack(alignment: .leading){
                                    
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .frame(height: 66)
                                    
                                    HStack(spacing: 30){
                                        Text(String(index+1))
                                            .bold()
                                        
                                        VStack(alignment: .leading){
                                            Text(lesson.title)
                                            Text(lesson.duration)
                                        }
                                    }
                                    .padding()
                                }
                                .padding(.bottom,10)
                            }
                        }
        
                    }
                    .padding()
                    .navigationTitle("Learn \(model.currentModule?.category ?? "")")
                }
            }
        }
        ```
        
    

### Tip of ForEach

- when loop through `lessons` , lesson does not contain index info
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%209.png)
    
- instead, we can do the following to use index to locate a lesson, in order to access to the attributes of lesson by index
    
    ```swift
    struct ContentView: View {
        
        //var module: Module
        @EnvironmentObject var model: ContentModel
        
        var body: some View {
            ScrollView{
                LazyVStack{
                    
                    // Confirm that currentModule is set
                    if model.currentModule != nil{
                        ForEach(0..<model.currentModule!.content.lessons.count){index in
                            
                            
                            let lesson = model.currentModule!.content.lessons[index]
                            
                            
                            // Lesson card
                            ZStack(alignment: .leading){
                                
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .frame(height: 66)
                                
                                HStack(spacing: 30){
                                    Text(String(index+1))
                                        .bold()
                                    
                                    VStack(alignment: .leading){
                                        Text(lesson.title)
                                        Text(lesson.duration)
                                    }
                                }
                                .padding()
                            }
                            .padding(.bottom,10)
                        }
                    }
    
                }
                .padding()
                .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            }
        }
    }
    ```
    

Other Q&A

- **How can you navigate from one view to another upon clicking a component/view?**
    - Use a NavigationLink inside of a NavigationView
    - The NavigationLink accepts a destination and a label, so when the label is clicked, the user navigates to the destination.

### Add a library in Xcode

- general-Frameworks and library
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2010.png)
    

### AVKit - Video Player

- Add AVKit framework in the Xcode project
- import AVKit for use
    
    ```swift
    // contains video player to show videos
    import AVKit
    ```
    
- how AVKit video player
    - pass in a video URL
    
    ```swift
    VideoPlayer(player: AVPlayer(url: URL))
    ```
    
- an example
    
    ```swift
    let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
    
    if url != nil{
        VideoPlayer(player: AVPlayer(url: url!))
            .cornerRadius(10)
    }
    ```
    
- Where is the video stored?
    1. You can upload the video to GitHub and create a relevant GitHub page, with which a web server is associated
    2. you can upload the video to vimeo
        
        [Vimeo | The world's only all-in-one video solution](https://vimeo.com/)
        

### Issue: pop back out

- When clicking an item, it pops back out
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2011.png)
    
- need to specify `.stack` as the navigation style
    
    ```swift
    NavigationView{...}
            .navigationViewStyle(.stack)
    ```
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2012.png)
    

### How to handle a more detailed level — lesson (module > content > lesson)

- create relevant functions in `ViewModels/ContentModel.swift`
    
    ```swift
    class ContentModel: ObservableObject {
        
        // List of modules
        @Published var modules: [Module] = [Module]()
        
        // Current module
        @Published var currentModule: Module?
        var currentModuleIndex = 0
        
        // Current lesson
        @Published var currentLesson: Lesson?
        var currentLessonIndex = 0
        
        
        var styleData : Data?
        
        init() {
            self.getLocalData()
        }
        
        // MARK: data methods
        func getLocalData(){...}
        
        // MARK: module navigation methods
        func beginModule(_ moduleId:Int){...}
        
        // MARK: lesson begin method
        func beginLesson(_ lessonIndex: Int){
            //check that the lesson index is within range of module lessons
            if lessonIndex < currentModule!.content.lessons.count{
                currentLessonIndex = lessonIndex
            }
            else{
                currentLessonIndex = 0
            }
            
            // set the current lesson
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        
        // MARK: check if there is next lesson
        func hasNextLesson() -> Bool {
            // more direct way
            return currentLessonIndex + 1 < currentModule!.content.lessons.count
        }
        
        // MARK: go to the next lesson
        func nextLesson(){
            // Advance the lesson index
            currentLessonIndex += 1
            
            // Check that it is within range
            if currentLessonIndex < currentModule!.content.lessons.count {
                
                // set the current lesson property
                currentLesson = currentModule!.content.lessons[currentLessonIndex]
            }
            else{
                // reset lesson
                currentLesson = nil
                currentLessonIndex = 0
            }
        }
    }
    ```
    
- derailed view: View/ContentDetailView.swift
    - get the current lesson
    - get the current lesson video accordingly
    - if the lesson has the next lesson, show a button to jump to the next lesson
    
    ```swift
    import SwiftUI
    import AVKit // contains video player to show videos
    
    struct ContentDetailView: View {
    
        @EnvironmentObject var model : ContentModel
        
        var body: some View {
            
            let lesson = model.currentLesson
            let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
            
            VStack{
                if url != nil{
                    VideoPlayer(player: AVPlayer(url: url!))
                        .cornerRadius(10)
                }
                
                //Description
                // Next lesson button
                if model.hasNextLesson(){
    
                        Button(action: {
                            model.nextLesson()
                        }) {
                            ZStack{
                                Rectangle()
                                    .frame( height: 48)
                                    .foregroundColor(Color.green) // should not use background
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                                    .foregroundColor(Color.white)
                                    .bold()
                            }
                        }
                    
                }
    
            }
            .padding()
        }
    }
    ```
    

### How to store server info

- create a constant view: `Resources/Constants.swift`
    
    ```swift
    import Foundation
    
    struct Constants {
        static var videoHostUrl = "https://codewithchris.github.io/learningJSON/"
    }
    ```
    
- how to use it
    
    ```swift
    // example
    let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
    ```
    

### UIViewRepresentable

- reference
    
    [Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/uiviewrepresentable)
    
- **`UIViewRepresentable`**
    - def: A wrapper for a UIKit view that you use to integrate that view into your SwiftUI view hierarchy.
    - What is required in a UIViewRepresentable
        - A makeUIView method
        - A updateUIView method
- Methods
    - `[func makeUIView(context: Self.Context) -> Self.UIViewType](https://developer.apple.com/documentation/swiftui/uiviewrepresentable/makeuiview(context:))`
        - Creates the view object and configures its initial state.
    - `[func updateUIView(Self.UIViewType, context: Self.Context)](https://developer.apple.com/documentation/swiftui/uiviewrepresentable/updateuiview(_:context:))`
        - Updates the state of the specified view with new information from SwiftUI.
        - Parameters
            - **`uiView`**Your custom view object.
            - **`context`**A context structure containing information about the current state of the system.

### Use MKMapView

- show map and wrap in UIKit view
    - need to define the two functions: **`makeUIView`** and **`updateUIView`**
    
    ```swift
    import SwiftUI
    import MapKit
    
    struct LearnMapView: UIViewRepresentable {
        func makeUIView(context: Self.Context) -> MKMapView  {
            
            // Creates the view object and configures its initial state.
            let mapView = MKMapView()
            
            return mapView
        }
        
        // uiView: Your custom view object.
        // context: A context structure containing information about the current state of the system.
        func updateUIView(_ uiView: MKMapView, context: Self.Context){
            // Update the element if needed
            
        }
    }
    ```
    

### 2 ways to handle the error

```swift
// convert to attributed string
// ---------method 1: can respond to error
do {
    let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    resultString = attributedString
}
catch
{
    print("Could not turn html into attributed string")
}

// ---------method 2: shorter but not be able to respond to errors
if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
    // if the condition after `try?` fails, this code will not be executed
    resultString = attributedString
}
```

### WKWebView

- load URL
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2013.png)
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2014.png)
    

### Navigation

- if two navigation links navigates to the same view, how does it now which link to go back?
    - for example, the following two links both navigate to the same view `LearnNavigationSecondView`
        
        ```swift
        struct LearnNavigationLink: View {
            var body: some View {
                NavigationView{
                    VStack(spacing:20){
                        //link1 -> view2
                        NavigationLink(destination: LearnNavigationSecondView()) {
                            Text("Navigation Link 1")
                        }
                        
                        //link2 -> view2
                        NavigationLink(destination: LearnNavigationSecondView()) {
                            Text("Navigation Link 2")
                        }
                    }
        
                }
            }
        }
        ```
        
    - `TabView` know it since we assigned tags; similarly, we can specify tags for navigation link
        - pass `$selectedIndex` to `selection` in NavigationLink
            
            ```swift
            struct LearnNavigationLink: View {
                
                @State var selectedIndex: Int?
                
                var body: some View {
                    NavigationView{
                        VStack(spacing:20){
            
                            //link1 -> view2
                            NavigationLink(tag: 1, selection: $selectedIndex) {
                                LearnNavigationSecondView()
                            } label: {
                                Text("Navigation Link 1")
                            }
                            
                            
                            //link2 -> view2
                            NavigationLink(tag: 2, selection: $selectedIndex) {
                                LearnNavigationSecondView()
                            } label: {
                                Text("Navigation Link 2")
                            }
            
                        }
            
                    }
                }
            }
            ```
            
        - check with `.onAppear`
            
            ```swift
            struct LearnNavigationLink: View {
                
                @State var selectedIndex: Int?
                
                var body: some View {
                    NavigationView{
                        VStack(spacing:20){
            
                            //link1 -> view2
                            NavigationLink(tag: 1, selection: $selectedIndex) {
                                LearnNavigationSecondView()
                                    .onAppear {
                                        print(selectedIndex)
                                    }
                            } label: {
                                Text("Navigation Link 1")
                            }
                            
                            
                            //link2 -> view2
                            NavigationLink(tag: 2, selection: $selectedIndex) {
                                LearnNavigationSecondView()
                                    .onAppear {
                                        print(selectedIndex)
                                    }
                            } label: {
                                Text("Navigation Link 2")
                            }
            
                        }
            
                    }
                }
            }
            ```
            
- You can pass the selectedIndex in the navigated view as binding var
    
    `@Binding var selectedIndex:Int?`
    
    - when click the button, reset the `selectedIndex` to be `nil` , this actually turns back to the home view since no navigation view is selected!
    
    ```swift
    import SwiftUI
    
    struct LearnNavigationSecondView: View {
        
        @Binding var selectedIndex:Int?
        
        var body: some View {
            VStack{
                Text("Hello, World!")
                Button("Navigate Back"){
                    selectedIndex = nil
                }
            }
            
        }
    }
    //
    //struct LearnNavigationSecondView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        LearnNavigationSecondView()
    //    }
    //}
    ```
    
- when creating the view, we need to pass the binding parameter
    
    `@State var selectedIndex: Int?`
    
    ```swift
    import SwiftUI
    
    struct LearnNavigationLink: View {
        
        @State var selectedIndex: Int?
        
        var body: some View {
            NavigationView{
                VStack(spacing:20){
    
                    //link1 -> view2
                    NavigationLink(tag: 1, selection: $selectedIndex) {
                        LearnNavigationSecondView(selectedIndex: $selectedIndex)
                    } label: {
                        Text("Navigation Link 1")
                    }
                    
                    
                    //link2 -> view2
                    NavigationLink(tag: 2, selection: $selectedIndex) {
                        LearnNavigationSecondView(selectedIndex: $selectedIndex)
                    } label: {
                        Text("Navigation Link 2")
                    }
    
                }
    
            }
        }
    }
    ```
    

### Example of using navigation tag

- instead of creating a @State property in the parent view, we can directly create a var in the view model `ContentModel`
    
    ```swift
    class ContentModel: ObservableObject {
        ...
        
        // Current selected content and test
        @Published var currentContentSelected: Int?
    }
    ```
    
- Parent view: View/HomeView
    - Use `[module.id](http://module.id)` as tag
    - use `$model.currentContentSelected` as selection (binding var)
        
        `NavigationLink(tag: module.id, selection: $model.currentContentSelected)`
        
    
    ```swift
    struct HomeView: View {
        
        @EnvironmentObject var model: ContentModel
        
        var body: some View {
            
            NavigationView{
                VStack(alignment: .leading){
                    Text("What do you want to do today?")
                        .padding(.leading,20)
                    
                    
                    ScrollView{
                        LazyVStack{
                            ForEach(model.modules){ module in
                                VStack(spacing: 20){
                                    NavigationLink(tag: module.id, selection: $model.currentContentSelected){
                                        ContentView()
                                            .onAppear {
                                                model.beginModule(module.id)
                                                print(model.currentContentSelected)
                                            }
                                    } label: {
                                        //Learning card
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                    }
    
                                    
    
                                    // Test card
                                    HomeViewRow(image: module.test.image, title: "Learn \(module.category)", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
    
                                }
                            }
                        }
                        .accentColor(.black)
                        .padding()
                    }
                }
                .navigationTitle("Get Started")
            }
            .navigationViewStyle(.stack)
        }
    }
    ```
    
- Navigated(child) view: View/ContentDetailView
    - use `model.currentContentSelected = nil` in button to get it back
    
    ```swift
    struct ContentDetailView: View {
        
        @EnvironmentObject var model : ContentModel
        
        var body: some View {
            
            let lesson = model.currentLesson
            let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
            
            VStack{
                if url != nil{
                    VideoPlayer(player: AVPlayer(url: url!))
                        .cornerRadius(10)
                }
                
                //Description
                CodeTextView()
                
                // Next lesson button
                if model.hasNextLesson(){
    
                        Button(action: {
                            model.nextLesson()
                        }) {
                            ZStack{
                                Rectangle()
                                    .frame( height: 48)
                                    .foregroundColor(Color.green) // should not use background
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                                    .foregroundColor(Color.white)
                                    .bold()
                            }
                        }
                    
                }
                else{
                    // show the complete button instead
                    Button(action: {
                        // take the user back to the home view
                        model.currentContentSelected = nil
                    }) {
                        ZStack{
                            Rectangle()
                                .frame( height: 48)
                                .foregroundColor(Color.green) // should not use background
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Text("Complete")
                                .foregroundColor(Color.white)
                                .bold()
                        }
                    }
                }
    
            }
            .padding()
            .navigationTitle(lesson?.title ?? "")
        }
    }
    ```
    

### View component template

- template view with parameter
    - default color is set to be white
    
    ```swift
    struct RectangleCardView: View {
        //default color
        var color = Color.white
        
        var body: some View {
            Rectangle()
    //            .frame( height: 48)
                .foregroundColor(color) // should not use background
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
    ```
    

Fix a prior navigation bug

- issue: when multiple navigation links in one view, typing one of them will automatically be jumped back to the parent view
- looks this bug has been fixed now
- solution：
    
    ```swift
    ForEach(model.modules){ module in
      VStack(spacing: 20){
          
          
          NavigationLink(tag: module.id, selection: $model.currentContentSelected){
              ContentView()
                  .onAppear {
                      model.beginModule(module.id)
                      print(model.currentContentSelected)
                  }
          } label: {
              //Learning card
              HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
          }
    
          NavigationLink(tag: module.id, selection: $model.currentTestSelected) { 
              TestView()
          } label: {
              // Test card
              HomeViewRow(image: module.test.image, title: "Learn \(module.category)", description: module.test.description, count: "\(module.test.questions.count) Questions", time: module.test.time)
          }
    
    	// To fix a prior bug:
    	    // when multiple navigation links in one view, typing one of them will automatically be jumped back to the parent view
    	    NavigationLink(destination: EmptyView()) {
    	        EmptyView()
    	    }
    
      }
    }
    ```
    
    ### `.disabled` button
    
    You can use the .disabled modifier on a button and pass in a boolean value to determine whether or not the button will work
    
    ### Double
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2015.png)
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2016.png)
    

### Github data host

- host data using github page
    - You don't need an index.html file since we're only hosting a file instead of a website. You can just directly navigate to the (JSON) file you're hosting (ex. www.codewithchris.github.io/app/data.json)
    
    [](https://zidiefeng.github.io/swiftUI-study/data.json)
    
- if including data to the app bundle, it cannot be uploaded frequently (we need to submit a new app version to the app store)
    - for data that need to be frequently updated, we upload them to the server/host

### Get remote data

- check if it can return `nil` in the function def
    - URL
        - correct: [https://zidiefeng.github.io/swiftUI-study/data.json](https://zidiefeng.github.io/swiftUI-study/data.json)
        - wrong:[https://github.com/Zidiefeng/swiftUI-study/blob/m5-data/data.json](https://github.com/Zidiefeng/swiftUI-study/blob/m5-data/data.json)
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2017.png)
    
- when creating a session, no need to create an instance since this is singleton object
    - singleton object: only one instance
    - `URLSession.shared` directly returns this singleton object
    
    ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2018.png)
    
- session.dataTask
    - multiple types of input; if using URL, we need to specify the attribute within it in advance
        
        ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2019.png)
        
    - data: the data returned from the request
    - response: additional info about the response
    - error: if no error occurs, this would be `nil`
- What is a URLSession?
    - A class that coordinates network related tasks
    - We can use the URLSession to fire off requests and work with any response such as returned JSONs.
- What do you need to do to execute a dataTask method once it is created?
    - To call the resume method to actually start the data task.
- code
    
    ```swift
    // MARK: get remote data
    func getRemoteData(){
        
        //String path
        let urlString = "https://codewithchris.github.io/learningapp-data/data2.json" //"https://zidiefeng.github.io/swiftUI-study/data.json"
        
        // create a url object
        let url = URL(string: urlString)
        
        // if no url, exit this data request
        guard url != nil else{
            return
        }
        
        // create a urlRequest object
        let request = URLRequest(url: url!)
        
        // get the session and kick of the task/request
        let session = URLSession.shared
        
        
        
        // returns data task object, so save as a container
        let dataTask = session.dataTask(with: request) { data, response, error in
            // data:returned data
            // response: additional info
            
            // check if there is an error
            guard error == nil else {
                // if there is an error, end this request
                return
            }
            
            do{
                //create json decoder
                let decoder = JSONDecoder()
                
                // decode
                let modules = try decoder.decode([Module].self, from: data!)
                self.modules += modules
            }
            catch{
                print(error)
            }
        }
        
        // kick off the data task
        dataTask.resume()
    ```
    

### Background Thread

- when doing a network request, it's using background thread to do it
- main stream:
    - update UI (changes on view)
    - need to maintain its freedom
- it is very slow to use background thread to do UI updates, so avoid this
    - warning sign
        
        ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2020.png)
        
- when want to switch to main stream to do the UI updates, use `DispatchQueue.main.async`
    
    ```swift
    // assign it to the main stream
    DispatchQueue.main.async {
        self.modules += modules
    }
    ```
    
- What does `DispatchQueue.main.async { ... }` do?
    - It will assign the code to the main thread to be taken care instead of in a background thread

### Debug a issue

- bug description
    - if a user firstly entered the first tab `Learn Swift`, and then go back to enter the third tab `Learn SwiftUI`, it crashed
        
        ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2021.png)
        
    - What happened
        1. the first time entered first tab `Learn Swift`
            - it firstly entered `ContentView()`, but since `module.currentModule` is nil, nothing shows up
            - after showing `ContentView()`, it triggered `.onAppear` and set current module
            
            ```swift
            ContentView()
              .onAppear {
                  model.beginModule(module.id)
                  print(model.currentContentSelected)
              }
            ```
            
            ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2022.png)
            
        2. now the current module is set to be the first tab
        3. when it go back to enter tab 3
            
            <aside>
            💡 view shows up first and then triggered `onAppear`
            
            </aside>
            
            - it firstly entered `ContentView()` , where it print out all lessons in the current module
            - however, now the current module is tab 1 instead of tab 3
            - since the current module is not nil, it starts the loop to show lessons in a class
            - tab 3 only has 9 lessons but tab 1 has 10 lessons, using index in tab 1 for tab 3 will have a `out of index range` error
- solutions for debugging
    - solution 1: do a check on the index
        - not good enough since the index itself might not be correct
    - solution 2: when leaving contentView, set the current module to be `nil` using `.onDisappear`
        
        ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2023.png)
        
        - the solution is not perfect since if a user is not going back to the home view from content view but from a deeper level view, it does not work
    - solution 3：when going back to home view, the current module is set to be `nil`
        - Going back to home view is equivalent to `model.currentContentSelected = nil`
            
            ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2024.png)
            
        - we can monitor if `model.currentContentSelected` if updated to `nil` (back to home view). If so, we can set `model.currentModule` to `nil` by `.onChange`
            
            ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2025.png)
            
        - additionally, we need to make sure `model.currentModule` is not `nil` when using it
            
            ```swift
            //---------------------Example 1
            // before
            let lesson = model.currentModule!.content.lessons[index]
            
            // after
            var lesson: Lesson {
            	//check if nil and index boundary
              if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
                  return lesson = model.currentModule!.content.lessons[index]
              }
              else{
                  return Lesson(id: 0, title: "", video: "", duration: "", explanation: "")
              }
            }
            
            //---------------------Example 2
            // before
            func hasNextLesson() -> Bool {
                return currentLessonIndex + 1 < currentModule!.content.lessons.count
            }
            
            //after
            func hasNextLesson() -> Bool {
            	// check if nil first
              guard currentModule != nil else{
                  return false
              }
              return currentLessonIndex + 1 < currentModule!.content.lessons.count
            }
            ```
            
            alternatively, we can use `??`
            
            ![Untitled](SwiftUI-CWC-M5%204748f9ead93942b28dde61254b903887/Untitled%2026.png)
            
    

### Module 5 Lesson 16 Xcode Issue Skipped

- since no error was found in the current version of Xcode, skipped this lesson