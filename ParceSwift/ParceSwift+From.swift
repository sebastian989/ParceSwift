//
//  Parseable.swift
//  TestReflection
//
//  Created by Sebastián Gómez and Leonardo Armero Barbosa on 20/02/16.
//  Copyright © 2016 Sebastián Gómez. All rights reserved.
//

import Foundation

/**
 NSObject extension to get a Dictionary or JSON String from object
 */
public extension NSObject {
    
    /**
     Fills the current NSObject with JSON data.
     
     - Parameter json: String with JSON data.
     
     - Throws: If an internal error occurs, upon throws contains an NSError object that describes the problem.
     */
    public func fromJSON(_ json: String) throws {
        var dictionary: [String: AnyObject]?
        if let data = json.data(using: String.Encoding.utf8) {
            do {
                dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                fromDictionary(dictionary!)
            } catch let error as NSError {
                throw error
            }
        }
    }
    
    /**
     Fills the current NSObject with a Dictionary data.
     
     - parameter json: Dictionary with data.
     */
    public func fromDictionary(_ json: [String: AnyObject]) {
        
        let propertyAndTypes = self.getPropertiesAndType()
        
        let customKeys: [String : String]? = self.customKeysName()
        
        for (label, type) in propertyAndTypes {
            var customKey = label
            
            if let custom = customKeys?[label] {
                customKey = custom
            }
            
            guard let propertyValue = json[customKey] else {
                continue
            }
            
            if let stringValue = propertyValue as? String {
                self.setValue(stringValue, forKey: label)
                continue
            }
            
            if let intValue = propertyValue as? NSNumber {
                if type == "String" {
                    self.setValue(String(describing: intValue), forKey: label)
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
    
    public class func fromJsonArray<T : NSObject>(_ array: [[String: AnyObject]]) -> [T] {
        var arrayObjects = [T]()
        
        for item in array {
            let object = T()
            object.fromDictionary(item)
            arrayObjects.append(object)
        }
        
        return arrayObjects
    }
}
