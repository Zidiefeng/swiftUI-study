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
                    //Text(.content.description)module
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
                            .font(Font.system(size: 8))
                        
                        Spacer()
                        
                        //time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        //Text(module.content.time)
                        Text(time)
                            .font(Font.system(size: 8))
                        
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
