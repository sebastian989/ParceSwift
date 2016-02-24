//
//  Parseable.swift
//  TestReflection
//
//  Created by Sebastián Gómez and Leonardo Armero Barbosa on 20/02/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

/**
 NSObject extension to transform a Dictionary to and from object
 */
public extension NSObject {
    
    /**
     Fills the current NSObject with a Dictionary data.
     
     - parameter json: Dictionary with data.
     */
    public func fromDictionary(json: [String: AnyObject]) {
        
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
                if type == "String" {
                    self.setValue(String(intValue), forKey: label)
                } else {
                    self.setValue(intValue, forKey: label)
                }
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
    
    /**
     Transforms the current NSObject to Dictionary.
     
     - returns: Dictionary with data.
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary = Dictionary<String, AnyObject>()
        
        let propertyAndTypes = self.getPropertiesAndType()
        for (label, _) in propertyAndTypes {
            
            guard let propertyValue = self.valueForKey(label) else {
                continue
            }
            
            if propertyValue is String
            {
                dictionary[label] = propertyValue as! String
            }
                
            else if propertyValue is NSNumber
            {
                dictionary[label] = propertyValue as! NSNumber
            }
                
            else if propertyValue is Array<String>
            {
                dictionary[label] = propertyValue
            }
                
            else if propertyValue is Array<AnyObject>
            {
                var array = Array<[String: AnyObject]>()
                
                for item in (propertyValue as! Array<AnyObject>) {
                    array.append(item.toDictionary())
                }
                
                dictionary[label] = array
            }
            // AnyObject
            else
            {
                dictionary[label] = propertyValue.toDictionary()
            }
        }
        return dictionary
    }
    
    /**
     Get a dictionary with label-value of properties of the current NSObject
     
     - returns: Dictionary with label-value of properties.
     */
    func getPropertiesAndType() -> [String : String] {
        var propertiesAndType = [String: String]()
        let aMirror = Mirror(reflecting: self)
        
        for case let (label?, value) in aMirror.children {
            propertiesAndType[label] = "\(Mirror(reflecting: value).subjectType)".componentsSeparatedByString("<").last!.componentsSeparatedByString(">").first
        }
        
        return propertiesAndType
    }
    
    /**
     Get type of a class from their class name.
     
     - parameter className: String with class name.
     - returns: Class type ready to initializing.
     */
    func swiftClassFromString(className: String) -> NSObject.Type {
        let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
        let path = appName + "." + className
        let anyClass: AnyClass = NSClassFromString(path)!
        return anyClass as! NSObject.Type
    }
    
}