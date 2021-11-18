# SwiftUI-CWC-M4

### TabView

- code
    
    ```swift
    // CWC Module 4 Lesson 3 TabView example （single file）
    
    //  TestView.swift
    //  recipe list app
    //
    //  Created by 孙恺檀 on 10/30/21.
    //
    
    import SwiftUI
    
    struct TestTabView: View {
        
        // it will be notified when user select certain tag
        // tabIndex will be updated accordingly
        @State var tabIndex = 0
        
        var body: some View {
            
            // Tab View: define tabs and their associated views
            // using `$` for binding
            // two way binding:
                //when tabIndex is changed, the tab view will be switched accordingly
                //when user select certain tag, the tabIndex value will be updated as well
            TabView(selection: $tabIndex){
                // The first tab
                // this item is associated with the tab
                Text("This is Tab 1")
                    .tabItem{
                        // how does the tab look like
                        VStack{
                            Image(systemName: "pencil")
                            Text("Tab 1")
                        }
                    }
                    // assign a tag index to this tag
                    .tag(0)
                
                // The second tab
                VStack{
                    Text("This is Tabe 2")
                    Text("This is some more text")
                }
                .tabItem{
                    VStack{
                        Image(systemName: "star")
                        Text("Tab 2")
                    }
                }
                .tag(1)
            }
            
    
        }
    }
    
    struct TestView_Previews: PreviewProvider {
        static var previews: some View {
            TestTabView()
        }
    }
    ```
    

### Default

- Default shape will occur all available space
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled.png)
    

### Frame

- The `frame` modifier will constrain the original resulting item into a certain frame
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%201.png)
    
- if the resulting item is smaller than the frame, we can specify `alignment` attribute

### Geometry Reader

- `.global` and `.local`
    
    ```swift
    struct TestGeometryReader: View {
        var body: some View {
            GeometryReader{geo in
                
                // all items inside geometry reader will be set to top left
                Rectangle()
                    .frame(width: geo.size.width/4, height: geo.size.height/8, alignment: .center)
                    .onTapGesture {
                        // input parameter in frame: specify if it's relative to local/parent frame or global/entire frame
    										// global: (0,47), showing the rectangle item's position relative to the entire frame
                        print("x:\(geo.frame(in: .global).minX) , y:\(geo.frame(in: .global).minY)")
    										//local, (0, 0), showing the rectangle item's position relative to the parent frame(the original geometry reader space, which extends to the available the safe space)
                        print("x:\(geo.frame(in: .local).minX) , y:\(geo.frame(in: .local).minY)")
                    }
            }
        }
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%202.png)
    
- `.ignoresSafeArea()` on GeometryReader
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%203.png)
    
- the 2 rectangles show the same local and global position
    - Question: Why does the green one use the top left corner of the black one as the position itself?
    - reason:
        - We are getting the relative position based on `geo` , which referred to the same `GeometryReader` space in this case
        - The coordinates are referred to the same `GeometryReader` Space
        - The `GeomtryReader` extends to the entire available space by default
    
    ```swift
    struct TestGeometryReader: View {
        var body: some View {
            GeometryReader{geo in
                
                VStack{
                    // all items inside geometry reader will be set to top left
                    Rectangle()
                        .frame(width: geo.size.width/4, height: geo.size.height/8, alignment: .center)
                        .onTapGesture {
                            // input parameter in frame: specify if it's relative to local/parent frame or global/entire frame
                            print("x:\(geo.frame(in: .global).minX) , y:\(geo.frame(in: .global).minY)")
                            print("x:\(geo.frame(in: .local).minX) , y:\(geo.frame(in: .local).minY)")
                        }
                    
                    // all items inside geometry reader will be set to top left
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(width: geo.size.width/4, height: geo.size.height/8, alignment: .center)
                        .onTapGesture {
                            // input parameter in frame: specify if it's relative to local/parent frame or global/entire frame
                            print("x:\(geo.frame(in: .global).minX) , y:\(geo.frame(in: .global).minY)")
                            print("x:\(geo.frame(in: .local).minX) , y:\(geo.frame(in: .local).minY)")
                        }
                }
            }
        }
    }
    ```
    

![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%204.png)

- Solution: individually call their own `GeometryReader`
    - in this case, the two `GeometryReader` each take half of the available zone
    
    ```swift
    struct TestGeometryReader: View {
        var body: some View {
            
                
            VStack{
                GeometryReader{geo in
                    // all items inside geometry reader will be set to top left
                    Rectangle()
                        .frame(width: geo.size.width/4, height: geo.size.height/8, alignment: .center)
                        .onTapGesture {
                            // input parameter in frame: specify if it's relative to local/parent frame or global/entire frame
                            print("x:\(geo.frame(in: .global).minX) , y:\(geo.frame(in: .global).minY)")
                            print("x:\(geo.frame(in: .local).minX) , y:\(geo.frame(in: .local).minY)")
                        }
                }
                
                GeometryReader{geo in
                    // all items inside geometry reader will be set to top left
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(width: geo.size.width/4, height: geo.size.height/8, alignment: .center)
                        .onTapGesture {
                            // input parameter in frame: specify if it's relative to local/parent frame or global/entire frame
                            print("x:\(geo.frame(in: .global).minX) , y:\(geo.frame(in: .global).minY)")
                            print("x:\(geo.frame(in: .local).minX) , y:\(geo.frame(in: .local).minY)")
                        }
                }
                
                
                
    
            }
        }
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%205.png)
    
- Since now the `Geometry` zoom is just the first half, the relative height refer to the first half only
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%206.png)
    
- now the global position shows differently
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%207.png)
    
- If got two views (like 2 rectangles) in one `GeometryReader` , the second item would overlap/cover the first item like below
    - because `GeometryReader` is not like `vstack`
    - the second one will be on top of the first one
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%208.png)
    

### padding, offset

- original
    
    ```swift
    Rectangle()
      .foregroundColor(.red)
      .frame(width: 100, height: 100, alignment: .center)
    ```
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%209.png)
    
- padding
    - padding with equal width on 4 edges
        
        ```swift
        Rectangle()
          .foregroundColor(.red)
          .frame(width: 100, height: 100, alignment: .center)
          .padding()
        ```
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2010.png)
        
    - padding with customized width
        
        ```swift
        Rectangle()
        	.padding(.top, 30.0)
        	.padding(.trailing,20)
        	.foregroundColor(.red)
        	.frame(width: 100, height: 100, alignment: .center)
        ```
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2011.png)
        
- Offset
    
    ```swift
    Rectangle()
      .foregroundColor(.red)
      .frame(width: 100, height: 100, alignment: .center)
      .offset(x: 30, y: 20)
    ```
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2012.png)
    
- offset vs padding
    - padding + frame: padding makes the item smaller inside the frame（往里挤进去多少）
    - offset + frame: offset makes the item off(partially outside) the frame （偏离原frame多少，发生多少位移）
    - when 2 items are beside each other, it's the frames that matched with each other （多个item排列在一起的时候，一般是靠等大的frame连在一起）
        - 此时若想要相叠加的感觉，用offset
    - 对比例子
        - padding
            
            ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2013.png)
            
        - offset
            
            ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2014.png)
            
- position
    - specify the center of the item
        
        ```swift
        Rectangle()
          .foregroundColor(.red)
          .frame(width: 100, height: 100, alignment: .center)
          .position(x: 200, y: 100)
        ```
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2015.png)
        

### A `[Class]` property inside a class

- Models/Recipe.swift
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2016.png)
    
    Data/recipes.json
    
    ```swift
    [
    	{
    	    "name": "Mushroom Risotto",
    	    "featured": true,
    	    "image" : "mushroom risotto",
    	    "description": "Authentic Italian-style risotto cooked the slow and painful way, but oh so worth it. ",
    	    "prepTime": "20 minutes",
    	    "cookTime": "30 minutes",
    	    "totalTime": "50 minutes",
    	    "servings": 6,
    	    "highlights": [
    	        "Creamy",
    	        "Vegetarian"
    	    ],
    	    "ingredients": [
    	        {"name": "Chicken broth", "num": 6, "unit": "cup"},
    	        {"name": "Olive oil", "num": 3, "unit": "tablespoon"},
    	        {"name": "Portobello mushrooms", "num": 1, "unit": "pound"},
    	        {"name": "White mushrooms", "num": 1, "unit": "pound"},
    	        {"name": "Shallots, diced", "num": 2},
    	        {"name": "Arborio rice", "num": 3, "denom": 2, "unit": "cup"},
    	        {"name": "Dry white wine", "num": 1, "denom": 2, "unit": "cup"},
    	        {"name": "Sea salt", "unit": "To taste"},
    	        {"name": "Black pepper", "unit": "To taste"},
    	        {"name": "Chives, finely chopped", "num": 3, "unit": "tablespoon"},
    	        {"name": "Butter", "num": 4, "unit": "tablespoon"},
    	        {"name": "Parmesan cheese", "num": 1, "denom": 3, "unit": "cup"}
    	    ],
    	    "directions": [
    	        "In a saucepan, warm the broth over low heat.",
    	        "Warm 2 tablespoons olive oil in a large saucepan over medium-high heat. Stir in the mushrooms, and cook until soft, about 3 minutes. Remove mushrooms and their liquid, and set aside.",
    	        "Add 1 tablespoon olive oil to skillet, and stir in the shallots. Cook 1 minute. Add rice, stirring to coat with oil, about 2 minutes. When the rice has taken on a pale, golden color, pour in wine, stirring constantly until the wine is fully absorbed. Add 1/2 cup broth to the rice, and stir until the broth is absorbed. Continue adding broth 1/2 cup at a time, stirring continuously, until the liquid is absorbed and the rice is al dente, about 15 to 20 minutes.",
    	        "Remove from heat, and stir in mushrooms with their liquid, butter, chives, and parmesan. Season with salt and pepper to taste."
    	    ]
    	}, 
    ...
    ]
    ```
    
- need UUID for the sub class
    
    ```swift
    // add unique ID
    for r in recipeData{
        r.id = UUID()
        for i in r.ingredients {
            i.id = UUID()
        }
    }
    ```
    
    added the above code in service `DataService.swift` below 
    
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
                        for i in r.ingredients {
                            i.id = UUID()
                        }
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
    
- when use `ingredients` in the view `RecipeDetailView.swift`
    
    ```swift
    VStack(alignment: .leading){
        Text("Ingredients")
            .font(.headline)
            .padding(.vertical,5)
        //for identifiable object, ingredient, no id is needed! /*id: \.self*/
        ForEach(recipe.ingredients){item in
            Text("• "+item.name)
                .padding(.bottom, 1)
        }
    }
    ```
    
- code update:
    
    [https://github.com/Zidiefeng/swiftUI-study/commit/fbe8cc8c450e06068d4f03f584f338241d8c4cdc](https://github.com/Zidiefeng/swiftUI-study/commit/fbe8cc8c450e06068d4f03f584f338241d8c4cdc)
    

### How to pass data model to multiple views

1. option 1: create another model in the new view
    - issue: two RecipeModel instances in separate views
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2017.png)
    
2. option 2: create RecipeModel instance in the upper level, pass it into multiple views 
    - better solution
    - issue: need to pass model instance into the init() of each the subviews
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2018.png)
        
3. option 3:  
    - similar to option 2, but better
    - create the model instance in the upper level, and add `EnvironmentObject` modifier
    - for all the subviews of the upper-level view, add a property for the model
    - the property will automatically be populated with the model of the parent view
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2019.png)
    
    []()
    

### EnvironmentObject

- how to use `EnvironmentObject`
    - use `EnvironmentObject` on the parent view
    - all sub-views of that parent view can access the environment object
- Where to put `.environmentObject()` — top-level
    1. Example 1: put `EnvironmentObject` on the parent view
        - the `RecipeFeaturedView` and `RecipeListView` can access the environment object `RecipeModel()`
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2020.png)
        
    2. Example 2: put `EnvironmentObject` on the app entry point 
        - the `RecipeFeaturedView` and `RecipeListView` can access the environment object `RecipeModel()`
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2021.png)
        
- how to take the environment object in sub-views
    
    ```swift
    struct RecipeFeaturedView: View {
        
        // if create model here,
        // there would be two sets of dataset
        // not making any sense
        // should pass model here instead of creating one
        // @ObservedObject var model = RecipeModel()
        
        @EnvironmentObject var model: RecipeModel
    
        var body: some View {
            ...
        }
    }
    ```
    
- how to do preview for the sub-view
    
    ```swift
    struct RecipeFeaturedView_Previews: PreviewProvider {
        static var previews: some View {
            // to enable preview, add environmentObject here
            RecipeFeaturedView()
                .environmentObject(RecipeModel())
        }
    }
    ```
    

### Example- featured view

- EnvironmentObject + GeometryReader + indexViewStyle
- index view:
    - you can implement swipe-able cards using the .tabViewStyle modifer.
    - 3 dots
    - connect with tab view
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2022.png)
        
- code `RecipeFeaturedView.swift`
    - https://github.com/Zidiefeng/swiftUI-study/commit/a78f649dbbbf0ab1d3f84e4aa4bf2856a949
    
    ```swift
    import SwiftUI
    
    struct RecipeFeaturedView: View {
        
        // if create model here,
        // there would be two sets of dataset
        // not making any sense
        // should pass model here instead of creating one
        // @ObservedObject var model = RecipeModel()
        
        @EnvironmentObject var model: RecipeModel
    
        var body: some View {
            VStack(alignment: .leading, spacing: 0){
                Text("Featured Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top,40)
                    .font(.largeTitle)
                GeometryReader{ geo in
                    TabView {
                        
                        //loop through each recipe
                        ForEach(0..<model.recipes.count){ index in
                            
                            // only show those that should be featured
                            if model.recipes[index].featured {
                                
                                //recipe card
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.white)
                                        
                                    VStack(spacing: 0){
                                        Image(model.recipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipes[index].name)
                                            .padding(5)
                                    }
                                }.frame(width: geo.size.width - 40,
                                        height: geo.size.height - 100,
                                        alignment: .center)
                                 .cornerRadius(25)
                                 .shadow(radius: 10)
                                
                            }
                            
                        }
                        
                    }
                    //automatic, if only one, no dot
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: -5, y: 5)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text(" Preparation Time:")
                        .font(.headline)
                    Text("1 hour")
                    
                    Text("Highlights")
                        .font(.headline)
                    Text("Healthy, Hearty")
                }
                .padding([.leading,.bottom])
            }
            
    
        }
    }
    ```
    

### Adjust titles in different views

- Currently, the two main views have different title format
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2023.png)
    
    - Left: RecipeListView()
        - used `navigationBarTitle`
        - the navigation view is formatting the title
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2024.png)
        
    - Right: RecipeFeaturedView()
        - use text for the title
        
        ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2025.png)
        
- handle the difference
    - strategy:
        - delete the `navigationBarTitle` by
            
            ```swift
            .navigationBarHidden(true)
            ```
            
        - use text with same modifiers as the other view
    - before
        
        ```swift
        struct RecipeListView: View {
            // use the environment object passed from the parent viewe
            @EnvironmentObject var model: RecipeModel
            var body: some View {
                NavigationView {
                    List(model.recipes){r in
                        
                        NavigationLink(
                            destination: RecipeDetailView(recipe: r),
                            label: {
                                    // MARK: Row item
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
                                        
                                    }}
                        )
        
                    }
                    .navigationBarTitle("Recipes")
                }
            }
        }
        ```
        
    - after
        
        ```swift
        struct RecipeListView: View {
        
            // use the environment object passed from the parent viewe
            @EnvironmentObject var model: RecipeModel
            var body: some View {
                NavigationView {
                    VStack(alignment: .leading) {
                        Text("All Recipes")
                            .bold()
                            .padding(.leading)
                            .padding(.top,40)
                            .font(.largeTitle)
                        
                        List(model.recipes){r in
                            NavigationLink(
                                destination: RecipeDetailView(recipe: r),
                                label: {
                                        // MARK: Row item
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
                                        }}
                            )
        
                        }
                    }
                    .navigationBarHidden(true)
                }
            }
        }
        ```
        

### from list to scroll

- before
    
    ```swift
    List(model.recipes){r in
        NavigationLink(
            destination: RecipeDetailView(recipe: r),
            label: {
                    // MARK: Row item
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
                    }}
        )
    
    }
    ```
    
- after
    
    ```swift
    ScrollView{
      ForEach(model.recipes){r in
          NavigationLink(
              destination: RecipeDetailView(recipe: r),
              label: {
                      // MARK: Row item
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
                      }}
          )
    
      }
    }
    ```
    

### Lazy stack

- lazy stack is creating items only as needed
    
    <aside>
    💡 `LazyVStacks` and `VStacks` are functionally the same, but the main difference is that `LazyVStacks` are rendered lazily: it only renders items as needed/when they come into frame.
    
    </aside>
    
- example of lazy stack
    
    ```swift
    struct RecipeListView: View {
        
        // Reference to the view model
        // comment this, use environment object method instead
        // @ObservedObject var model = RecipeModel()
        
        
        // use the environment object passed from the parent viewe
        @EnvironmentObject var model: RecipeModel
        var body: some View {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("All Recipes")
                        .bold()
                        .padding(.top,40)
                        .font(.largeTitle)
                    
                    ScrollView{
                        LazyVStack(alignment: .leading){
                            ForEach(model.recipes){r in
                                NavigationLink(
                                    destination: RecipeDetailView(recipe: r),
                                    label: {
                                            // MARK: Row item
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
                                                    .foregroundColor(.black)
                                            }}
                                )
                            }
                        }
    
                    }
                }
                .navigationBarHidden(true)
                .padding(.leading)
            }
        }
    }
    ```
    

### Picker

- A picker requires a selection parameter to be passed in as a binding, so that the selected option is tracked through the passed in state property.
- The initial selected option will be the passed in selection parameter, so changing the state property will change the default value.
- string tag
    
    ```swift
    struct SwiftUIView: View {
        // keep track of the selected index of the picker
        // 2 way relationship
        // detect change of the user selection
        @State var selectedIndex = "1"
        
        var body: some View {
            VStack{
                Picker("Tap Me", selection: $selectedIndex) {
                    Text("Option 1")
                        .tag("1")
                    Text("Option 2")
                        .tag("2")
                    Text("Option 3")
                        .tag("3")
                }
                
                Text("You've selected: \(selectedIndex)")
            }
            
        }
    }
    ```
    
- int tag
    
    ```swift
    struct SwiftUIView: View {
        // keep track of the selected index of the picker
        // 2 way relationship
        // detect change of the user selection
        @State var selectedIndex = 1
        
        var body: some View {
            VStack{
                Picker("Tap Me", selection: $selectedIndex) {
                    Text("Option 1")
                        .tag(1)
                    Text("Option 2")
                        .tag(2)
                    Text("Option 3")
                        .tag(3)
                }
                
                Text("You've selected: \(selectedIndex)")
            }
            
        }
    }
    ```
    
- style
    
    ```swift
    struct SwiftUIView: View {
        // keep track of the selected index of the picker
        // 2 way relationship
        // detect change of the user selection
        @State var selectedIndex = 1
        
        var body: some View {
            VStack{
                Picker("Tap Me", selection: $selectedIndex) {
                    Text("Option 1")
                        .tag(1)
                    Text("Option 2")
                        .tag(2)
                    Text("Option 3")
                        .tag(3)
                }
                //.pickerStyle(MenuPickerStyle())
                .pickerStyle(SegmentedPickerStyle())
                
                Text("You've selected: \(selectedIndex)")
            }
            
        }
    }
    ```
    
    different styles
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2026.png)
    

### Serving Size

- formula
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2027.png)
    
- add picker
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2028.png)
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2029.png)
    
- add function to utilities: `Utilities/Rational.swift`
    
    ```swift
    import Foundation
    
    struct Rational {
        static func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int{
            // GCD(0,b) =b
            if a == 0 { return b }
            
            // GCD(0,b) =b
            if b == 0 { return a }
            
            // Otherwise, GCD(a,b) = GCD(b, remainder)
            return greatestCommonDivisor(b, a % b)
    
        }
    }
    ```
    
- add `getPortion` function to RecipeModel (ViewModel)
    
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
        
        
        static func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings:Int) -> String{
            
            var portion = ""
            var numerator = ingredient.num ?? 1 // if it's nil, it will take 1 instead
            var denominator = ingredient.denom ?? 1
            var wholePortions = 0
            
            if ingredient.num != nil {
                // Get a single serving size by multiplying denominator by the recipe servings
                denominator *= recipeServings
                
                
                // Get target portion by multiplying numerator by target servings
                numerator *= targetServings
                
                
                // Reduce fraction by greatest common divisor
                let divisor = Rational.greatestCommonDivisor(numerator, denominator)
                numerator /= divisor
                denominator /= divisor
                
                // Get the whole portion if numerator > denominator
                if numerator >= denominator{
                    // calculated whole portions
                    wholePortions = numerator / denominator
                    
                    //calculate the remainder
                    numerator = numerator % denominator // modulo - remainder
                    
                    //Assign to portion string
                    portion += String(wholePortions)
                }
                
                // express the remainder as a fraction
                if numerator > 0 {
                    // Assign remainder as a fraction
                    portion += wholePortions > 0 ? " " : ""
                    
                    portion += "\(numerator)/\(denominator)"
                }
            }
            if var unit = ingredient.unit {
                // calculate appropriate suffix
    
                
                if wholePortions > 1 {
                    if unit.suffix(2) == "ch" {
                        unit += "es"
                    }
                    else if unit.suffix(1) == "f" {
                        unit = String(unit.dropLast())
                        unit += "ves"
                    }
                    else{
                        unit += "s"
                    }
                }
    
                
                portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
                return portion + unit
            }
            
            // Express the remaindar
            return portion
        }
        
        
    }
    ```
    
- use the function above
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2030.png)
    

### ifelse()

```swift
// if true, A, else B
wholePortions > 0 ? " " : ""

// can be used inline
portion += wholePortions > 0 ? " " : ""
```

### Lowercase

```swift
item.name.lowercased()
```

### Turn featured card to button

- button
    - action: what to do after tapping the button
    - label: what does the button look like
    - `.sheet` : the view to present when isPresented is true
        - We can add the .sheet modifier to the button and modify the state property variable to determine if the sheet view should show or not.
    
    ```swift
    Button(action: {
            // show the recipe detail sheet
            self.isDetailViewShowing = true
        }) {
            //label: recipe card
        }
        .sheet(isPresented: $isDetailViewShowing){
            // show the Recipe Detail View
            RecipeDetailView(recipe: model.recipes[index])
        }
    ```
    
- code example:
    
    ```swift
    import SwiftUI
    
    struct RecipeFeaturedView: View {
        
        // if create model here,
        // there would be two sets of dataset
        // not making any sense
        // should pass model here instead of creating one
        // @ObservedObject var model = RecipeModel()
        
        @EnvironmentObject var model: RecipeModel
        
        @State var isDetailViewShowing = false
    
        var body: some View {
            VStack(alignment: .leading, spacing: 0){
                Text("Featured Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top,40)
                    .font(.largeTitle)
                GeometryReader{ geo in
                    TabView {
                        
                        //loop through each recipe
                        ForEach(0..<model.recipes.count){ index in
                            
                            // only show those that should be featured
                            if model.recipes[index].featured {
                                
                                Button(action: {
                                    // show the recipe detail sheet
                                    self.isDetailViewShowing = true
                                }) {
                                    //recipe card
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(.white)
                                            
                                        VStack(spacing: 0){
                                            Image(model.recipes[index].image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
                                            Text(model.recipes[index].name)
                                                .padding(5)
                                        }
                                    }
                                }
                                .sheet(isPresented: $isDetailViewShowing){
                                    // show the Recipe Detail View
                                    RecipeDetailView(recipe: model.recipes[index])
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: geo.size.width - 40,
                                        height: geo.size.height - 100,
                                        alignment: .center)
                                .cornerRadius(25)
                                .shadow(radius: 10)
                            }
                            
                        }
                        
                    }
                    //automatic, if only one, no dot
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: -5, y: 5)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text(" Preparation Time:")
                        .font(.headline)
                    Text("1 hour")
                    
                    Text("Highlights")
                        .font(.headline)
                    Text("Healthy, Hearty")
                }
                .padding([.leading,.bottom])
            }
            
    
        }
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2031.png)
    

### firstIndex

- **How can you find the first index of a specific element that matches a search criteria in an array?**
    - Use the `firstIndex` method on an array and specify your search criteria
    - \While the third option 【Loop through the array and find all elements that match the search criteria】would find elements in an array that matches the search criteria, it would give us all the elements instead of only the first index.
- explanation
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2032.png)
    
- code example
    - loop through `[model.recipes](http://model.recipes)` , if return true in loop, stop and return the index
    - For example, the following code return 1 since the second recipe in the array (index start from 0) is the first one that returns `true` from `recipe.featured`
    
    ```swift
    var index = model.recipes.firstIndex { recipe in
        return recipe.featured
    }
    ```
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2033.png)
    

### Select 1st featured card in default

- define a function to detect the index of the first featured recipe
    
    ```swift
    func setFeaturedIndex(){
        // Find the index of the first recipe that is featured
        var index = model.recipes.firstIndex { recipe in
            print(recipe.featured)
            print(recipe.name)
            return recipe.featured
        }
        tabSelectionIndex = index ?? 0
    }
    ```
    
- Use the following code to set default selected featured card
    - `.onAppear {setFeaturedIndex()}`
        - The onAppear modifier can be added to a view to run code when the view appears.
    - `@State var tabSelectionIndex = 0`
    - `TabView(selection: $tabSelectionIndex) {...}`
    
    ```swift
    import SwiftUI
    
    struct RecipeFeaturedView: View {
    
        @EnvironmentObject var model: RecipeModel
        @State var isDetailViewShowing = false
        @State var tabSelectionIndex = 0
    
        var body: some View {
            VStack(alignment: .leading, spacing: 0){
                Text("Featured Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top,40)
                    .font(.largeTitle)
                GeometryReader{ geo in
                    TabView(selection: $tabSelectionIndex) {
                        
                        //loop through each recipe
                        ForEach(0..<model.recipes.count){ index in
                            
                            // only show those that should be featured
                            if model.recipes[index].featured {
                                
                                Button(action: {
                                    // show the recipe detail sheet
                                    self.isDetailViewShowing = true
                                }) {
                                    //recipe card
                                    ZStack{
                                        Rectangle()
                                            .foregroundColor(.white)
                                            
                                        VStack(spacing: 0){
                                            Image(model.recipes[index].image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipped()
                                            Text(model.recipes[index].name)
                                                .padding(5)
                                        }
                                    }
                                }
                                .tag(index)
                                .sheet(isPresented: $isDetailViewShowing){
                                    // show the Recipe Detail View
                                    RecipeDetailView(recipe: model.recipes[index])
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: geo.size.width - 40,
                                        height: geo.size.height - 100,
                                        alignment: .center)
                                .cornerRadius(25)
                                .shadow(radius: 10)
                            }
                            
                        }
                        
                    }
                    //automatic, if only one, no dot
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.4), radius: 10, x: -5, y: 5)
                }
                
                VStack(alignment: .leading, spacing: 10){
                    Text(" Preparation Time:")
                        .font(.headline)
                    Text(model.recipes[tabSelectionIndex].prepTime)
                    
                    Text("Highlights")
                        .font(.headline)
                    RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
                }
                .padding([.leading,.bottom])
            }
            // when the vstack is shown, the following code is performed
            .onAppear {
                setFeaturedIndex()
            }
            
    
        }
    ```
    

### Create a data transformation function and return resulted view

- code: `Views\RecipeHighlights.swift`
    
    ```swift
    import SwiftUI
    
    struct RecipeHighlights: View {
        var allHighlights = ""
        
        init(highlights:[String]){
            //Loop through the highlights and build the string
            for index in 0..<highlights.count{
                // If this is the last item, don't add a comma
                
                if index == highlights.count - 1 {
                    allHighlights += highlights[index]
                }
                else{
                    allHighlights += highlights[index] + ", "
                }
            }
        }
        
        var body: some View {
            Text(allHighlights)
        }
    }
    
    struct RecipeHighlights_Previews: PreviewProvider {
        static var previews: some View {
            RecipeHighlights(highlights: ["test1","test2","test3"])
        }
    }
    ```
    
- Can call this transformation function and render relevant view in multiple views
    - featured view
        
        ```swift
        ...
        VStack(alignment: .leading, spacing: 10){
                        Text(" Preparation Time:")
                            .font(.headline)
                        Text(model.recipes[tabSelectionIndex].prepTime)
                        
                        Text("Highlights")
                            .font(.headline)
                        RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
                    }
        ...
        ```
        
    - list view
        
        ```swift
        ...
        VStack(alignment: .leading) {
            Text(r.name)
                .foregroundColor(.black)
                .bold()
            RecipeHighlights(highlights: r.highlights)
                .foregroundColor(.black)
        }
        ...
        ```
        

### Use Custom Font

- full tutorial
    
    [How to use custom fonts in Swift iOS app using SwiftUI - Simple Swift Guide](https://www.simpleswiftguide.com/how-to-use-custom-fonts-in-swift-ios-app-using-swiftui/)
    
- add font files into the app bundle (maybe in an asset folder)
    - remember to add to target and copy if necessary
- update `info.plist` to add every font file
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2034.png)
    
- use the new font
    
    ```swift
    Text("Simple Swift Guide").font(Font.custom("Chalkboard", size: 33))
    ```
    

### Use system font

- link
    
    [System Fonts](https://developer.apple.com/fonts/system-fonts/)
    
- example
    - `.font(Font.custom("Baskerville SemiBold", size: 40))`
    - This font is found in the link above
    
    ![Untitled](SwiftUI-CWC-M4%20891c6f19a3934015bfea2c72d82bca77/Untitled%2035.png)
    

### Homework Challenge

- My answer: [https://github.com/Zidiefeng/swiftUI-study/tree/main/m4-book-challenge/m4-book-challenge](https://github.com/Zidiefeng/swiftUI-study/tree/main/m4-book-challenge/m4-book-challenge)
- Solution： https://github.com/Zidiefeng/swiftUI-study/tree/main/m4-challenge
