//
//  ContentView.swift
//  lesson14
//
//  Created by 孙恺檀 on 10/24/21.
//

import SwiftUI

struct ContentView: View {
    var array = ["aaa","bbb","ccc"]
    var body: some View {
//        VStack{
//            ForEach(array, id: \.self){r in
//                Text(r)
//            }
//        }
        
        
//        ScrollView{
//            ForEach(0...2, id: \.self){i in
//                Text(String(i) + " " + array[i])
//            }
//        }
        
        
//        ScrollView{
//            ForEach(0...array.count-1, id: \.self){i in
//                Text(String(i) + " " + array[i])
//            }
//        }
        
        ScrollView{
            ForEach(0..<array.count, id: \.self){i in
                Text(String(i) + " " + array[i])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
