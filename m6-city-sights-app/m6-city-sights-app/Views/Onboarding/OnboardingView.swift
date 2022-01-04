//
//  OnboardingView.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 1/3/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var tabSelection = 0
    @EnvironmentObject var model: ContentModel
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    var body: some View {
        VStack{
            // tab view
            TabView(selection: $tabSelection) {
                // first tab
                VStack(spacing: 20){
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City Sights help you find the best of the city!")
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .tag(0)
                
                // second tab
                VStack(spacing: 20){
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We'll show you the best restaurants, venues and more, based on your location!")
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            //button
            Button{
                if tabSelection == 0 {
                    tabSelection = 1
                }
                else{
                    // request for geolocation permission
                    model.requestGeolocationPermission()
                }
            } label:{
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                    
                }
            }
            .accentColor(tabSelection == 0 ? blue : turquoise)
            .padding()
            
            Spacer()
        }
        .background(tabSelection == 0 ? blue : turquoise)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
