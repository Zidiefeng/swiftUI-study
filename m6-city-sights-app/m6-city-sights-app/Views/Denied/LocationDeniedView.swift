//
//  LocationDeniedView.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 1/4/22.
//

import SwiftUI

struct LocationDeniedView: View {
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    var body: some View {
        VStack{
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide with the best sights in the city. You can change your decision at any time in Settings.")
            
            Spacer()
            
            Button {
                // open settingsv
                if let url = URL(string: UIApplication.openSettingsURLString){
                    
                    // if we can open the settings url
                    if UIApplication.shared.canOpenURL(url){
                        // pass empty dictionary and no handler
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            } label: {
                ZStack{
                    Rectangle()
                        .frame(height: 48)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }
            }

            
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
