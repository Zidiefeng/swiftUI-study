//
//  ContentView.swift
//  m6-city-sights-app
//
//  Created by 孙恺檀 on 12/9/21.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        // detect the authorization status of geolocation
        if model.authorizationState == .notDetermined {
            // if undetermined, show onboarding
            OnboardingView()
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            // if approved, show home view
            HomeView()
        }
        else{
            // if denied, show denied view
            LocationDeniedView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
