//
//  Parseable.swift
//  TestReflection
//
//  Created by Sebastián Gómez on 20/02/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

extension NSObject {
    
    func fromDictionary(json: [String: AnyObject]) {

        let propertyAndTypes = self.getPropertiesAndType()
        
        for (label, type) in propertyAndTypes {
            
            guard let propertyValue = json[label] else {
                continue
            }
            
            if let stringValue = propertyValue as? String {
                self.setValue(stringValue, forKey: label)
                continue
            }
            
            if let intValue = propertyValue as? NSNumber {
                self.setValue(intValue, forKey: label)
                continue
            }
            
            
            // Array
            
            if let arrayValue = propertyValue as? [String] {
                self.setValue(arrayValue, forKey: label)
                continue
            }
            
            if let arrayValue = propertyValue as? [NSNumber] {
                self.setValue(arrayValue, forKey: label)
                continue
            }
            
            if let arrayValue = propertyValue as? [[String : AnyObject]] {
                var arrayObjects = [AnyObject]()
                for item in arrayValue {
                    let modelType : NSObject.Type = swiftClassFromString(type)
                    let modelObject = modelType.init()
                    modelObject.fromDictionary(item)
                    arrayObjects.append(modelObject)
                }
                self.setValue(arrayObjects, forKey: label)
                continue
            }
            
            
            // Dictionary
            
            if type == "String, String" || type == "String, Int" || type == "String, Bool"
                || type == "Int, String" {
                self.setValue(propertyValue, forKey: label)
                continue
            }
            
            if let modelValue = propertyValue as? [String:AnyObject] {
                let modelType : NSObject.Type = swiftClassFromString(type)
                let modelObject = modelType.init()
                modelObject.fromDictionary(modelValue)
                self.setValue(modelObject, forKey: label)
            }
        }
    }
    
    func getPropertiesAndType() -> [String : String] {
        var propertiesAndType = [String: String]()
        let aMirror = Mirror(reflecting: self)
        
        for case let (label?, value) in aMirror.children {
            propertiesAndType[label] = "\(Mirror(reflecting: value).subjectType)".componentsSeparatedByString("<").last!.componentsSeparatedByString(">").first
        }
        
        return propertiesAndType
    }
    
    func swiftClassFromString(className: String) -> NSObject.Type {
        let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
        let path = appName + "." + className
        let anyClass: AnyClass = NSClassFromString(path)!
        return anyClass as! NSObject.Type
    }
    
}