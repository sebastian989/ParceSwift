//
//  User.swift
//  TestReflection
//
//  Created by Sebastián Gómez on 20/02/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String?
    var age: NSNumber?
    var height: NSNumber!
    var isMan: Bool = false
    var address: Address?
    var anyDictionary: [String:Int]?
    var arrayAnyTypes: [Int]?
    var modelsArray: [Address]?
}
