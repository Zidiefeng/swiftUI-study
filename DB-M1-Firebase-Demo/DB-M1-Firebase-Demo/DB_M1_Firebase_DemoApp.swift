//
//  DB_M1_Firebase_DemoApp.swift
//  DB-M1-Firebase-Demo
//
//  Created by 孙恺檀 on 1/7/22.
//

import SwiftUI
import Firebase

@main
struct DB_M1_Firebase_DemoApp: App {
    
    init(){
        FirebaseApp.configure()
        // makeReservation()
        // updateReservation()
        // readDocument()
        // dataListener()
        compoundQuery()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    func queryData(){
        let db = Firestore.firestore()
        let reservations = db.collection("reservations")
        
        //query: return documents with "name" equals to Carol or Dave
        let query = reservations.whereField("name", in: ["Carol", "Dave"])
        
        //Execute the query
        query.getDocuments { query, error in
            for doc in query!.documents{
                print(doc.data())
            }
        }
        
        // Explore other queries
        reservations.whereField("name",notIn: ["Carol","Dave"])
        reservations.whereField("array", isEqualTo: 1)
        // query documents where its array has 1 or 2 or 3
        reservations.whereField("array", arrayContainsAny: [1,2,3])
    }
    
    
    func compoundQuery(){
        let db = Firestore.firestore()
        let reservations = db.collection("reservations")
        
        //create a composite query to the database
        let query = reservations
            .whereField("name", in: ["Dave","Carol"])
            .whereField("people", isLessThan: 20)
        
        // execute the query
        query.getDocuments { query, error in
            if let query = query {
                for doc in query.documents{
                    print(doc.data())
                }
            }
        }
    }
    
    
    func dataListener(){
        let db = Firestore.firestore()
        let reservations = db.collection("reservations")
        let document = reservations.document("test123")
        
        // add a snapshotlistener to the document
        // this will run over and over again
        // whenever changes are made to the doc, this will be run again
        let l1 = document.addSnapshotListener { doc, error in
            //check for errors
            print(doc?.data())
        }
        
        let l2 = reservations.addSnapshotListener { query, error in
            //check for errors
            
            // whenever anything has been changed, we can print all the documents in the collection
            for doc in query!.documents{
                print(doc.data())
            }
            
            // instead, we can print the documents that have been modified
            for doc in query!.documentChanges{
                print(doc.document.data())
            }
            
        }
        
        l1.remove()
        l2.remove()
        
    }
    
    

    
    func readDocument(){
      let db = Firestore.firestore()
      let reservations = db.collection("reservations")
      let document = reservations.document("test123")
      
      // get doc info of a specific document
      document.getDocument { doc, error in
          // check for an error and handle it appropriately
          if let error = error{
              print(error.localizedDescription)
          }
          else if let doc = doc {
              print(doc.data())
              print(doc.documentID)
          }
          else{
              // no data was returned, handle it appropriately
          }
      }
      
      // get all documents from a collection
      reservations.getDocuments { querySnapshot, error in
          if let error = error {
              // handle error
          }
          else if let query = querySnapshot{
              for doc in query.documents{
                  print(doc.documentID)
              }
          }
          else{
              // no data was returned
          }
      }
    }
    
    func errorHandler(){
        let db = Firestore.firestore()
        let reservations = db.collection("reservations")
        
        let doc = reservations.addDocument(data: [:]){ error in
            // check if there was an error
            // if there was, log it and return
            if let error = error {
                // Do any other error handling
                print(error.localizedDescription)
            }
            // otherwise, do nothing
            else{
                // call succeeded
                return
            }
        }
        doc.delete { error in
            // handle errors
        }
        
        doc.setData([:]) { error in
            // handle errors
        }
        
        doc.updateData([:]) { error in
            // handle errors
        }
        
    }
    
    
    
    
    func deleteReservation(){
        let db = Firestore.firestore()
        let reservations = db.collection("reservations")
        let reservation = reservations.addDocument(data: ["name":"Steve", "people":4])
        reservations.addDocument(data: ["name":"Cathy", "people":8])
        
        // Delete a field from a document
        reservation.updateData(["people":FieldValue.delete()])
        
        // Delete a entire document
        reservation.delete()
        
        // To delete a collection, it's recommended to go to UI to delete it
    }
    

    func makeReservation(){
        // refer to google service plist file to get credentials to access to the firebase db
        // reference t othe cloud firestore database
        let db = Firestore.firestore()
        
        // reference to the reservations collection
        // if there is an existing collection called reservations, we point to it
        // if there is not, we create one in the database
        let reservations = db.collection("reservations")
        
        // Create a document with a given identifier
        reservations.document("test123").setData(["name":"Carol","people": 22])
        
        // Create a document with a unique identifier
        reservations.document().setData(["name":"Lily"])
        
        // Create a document with given data (unique identifier)
        reservations.addDocument(data: ["name":"Tom", "people":10])
        
        // We can capture the newly pointed document
        let document = reservations.addDocument(data: ["name":"Lisa", "people":3])
    }
    
    func updateReservation(){
        let db = Firestore.firestore()
        let reservation = db.collection("reservations").document("test123")
        
        // overwrite the whole data
        reservation.setData(["name":"Carol", "people":24])
        reservation.setData(["people":24])
        
        // just update certain fields
        reservation.setData(["name":"Carol"], merge:true)
        
        // just update certain fields
        reservation.updateData(["people":12])
    }
}
