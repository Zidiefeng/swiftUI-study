//
//  loginForm.swift
//  DB-M2-Firebase-Auth-Demo
//
//  Created by 孙恺檀 on 1/31/22.
//

import Foundation
import SwiftUI
import FirebaseEmailAuthUI

struct LoginForm: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else{
            return UINavigationController()
        }
        
        let providers = [FUIEmailAuth()]
        authUI!.providers = providers
        
        return authUI!.authViewController()
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}
