//
//  UserService.swift
//  m5-learning-app
//
//  Created by 孙恺檀 on 2/1/22.
//

import Foundation
class UserService{
    var user = User()
    
    // always return the same singleton instance
    static var shared = UserService()
    
    //prevent creating instance elsewhere
    private init(){
        
    }
}
