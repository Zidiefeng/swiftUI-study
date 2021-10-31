//
//  TestGeometryReader.swift
//  recipe list app
//
//  Created by 孙恺檀 on 10/30/21.
//

import SwiftUI

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
                
                Rectangle()
                    //.padding(.top, 30.0)
                    //.padding(.trailing,20)
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100, alignment: .center)
                    //.offset(x: 30, y: 20)
                    .position(x: 200, y: 100)
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

struct TestGeometryReader_Previews: PreviewProvider {
    static var previews: some View {
        TestGeometryReader()
    }
}
