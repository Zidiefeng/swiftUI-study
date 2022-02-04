//
//  Rational.swift
//  recipe list app
//
//  Created by 孙恺檀 on 11/11/21.
//

import Foundation

struct Rational {
    static func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int{
        // GCD(0,b) =b
        if a == 0 { return b }
        
        // GCD(0,b) =b
        if b == 0 { return a }
        
        // Otherwise, GCD(a,b) = GCD(b, remainder)
        return greatestCommonDivisor(b, a % b)

    }
}
