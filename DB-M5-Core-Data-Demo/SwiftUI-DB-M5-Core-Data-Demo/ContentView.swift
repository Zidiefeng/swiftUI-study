//
//  ContentView.swift
//  SwiftUI-DB-M5-Core-Data-Demo
//
//  Created by 孙恺檀 on 1/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(sortDescriptors: []) var peopleList: FetchedResults<People>
    
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "age", ascending: true)]) var peopleList: FetchedResults<People>
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "age", ascending: true)], predicate: NSPredicate(format: "name contains 'Tom'")) var peopleList: FetchedResults<People>

    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var families: FetchedResults<Family>
    
    @State var peopleList = [People]()
//    @State var filterByText = ""
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//
//
    
//    private var items: FetchedResults<Item>

    var body: some View {

        VStack{
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
            
            List{
                ForEach(families){family in
                    Text("\(family.name ?? ""), member count: \(family.members?.count ?? 0)")
                }
            }
            
            
            
//            TextField("Filter Text", text: $filterByText)
//                .border(Color.black, width: 1)
//                .padding()
            
//            List{
//                ForEach(peopleList){p in
//                    Text("\(p.name ?? "No Name") age: \(p.age ?? "No Age")")
//                        .onTapGesture {
//                            viewContext.delete(p)
//                            // if failed, not care about the error
//                            try! viewContext.save()
//                        }
////                        .onTapGesture {
////                            p.name = "Joe"
////                            // if failed, not care about the error
////                            try! viewContext.save()
////                        }
//                }
//            }
        }
//        .onChange(of: filterByText) { newValue in
//            fetchData()
//        }
    }
    
    func sampleCode(){
        let f = Family(context: viewContext)
        f.name = "Modern Family"
        
        let p = People(context: viewContext)
        p.family = f
        
        f.addToMembers(p)
        
        try! viewContext.save()
    }
    
    
//    func fetchData() {
//        // create fetch request
//        let request = People.fetchRequest()
//        
//        // set sort descriptions and predicates
//        request.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]
//        request.predicate = NSPredicate(format: "name contains %@", filterByText)
//        
//        //execute in main thread to update the list UI
//        DispatchQueue.main.async {
//            do{
//                let results = try viewContext.fetch(request)
//                
//                //update the state property
//                self.peopleList = results
//            }
//            catch{
//                print(error.localizedDescription)
//            }
//        }
//
//    }

    private func addItem() {
        let family = Family(context: viewContext)
        family.name = String("Family \(Int.random(in: 0...20))")
        
        let numberOfMembers = Int.random(in: 0...5)
        for i in 0...numberOfMembers{
            let p = People(context: viewContext)
            p.age = String(Int.random(in:0...20))
            p.name = "Person \(i)"
            p.family = family
        }
        
        // create a new person object only (not saved yet)
        // Specify we intend to save it in core data
        let p = People(context: viewContext)
        p.name = "Tom"
        p.age = String(Int.random(in: 0...29))
        
        do {
            try viewContext.save()
        }
        catch{
            // error with saving
        }
    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
