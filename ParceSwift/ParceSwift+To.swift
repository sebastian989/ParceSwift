//
//  ParceSwift+To.swift
//  Demo
//
//  Created by Leonardo Armero Barbosa on 25/02/16.
//
//

import Foundation

/**
 NSObject extension to transform a Dictionary or JSON to object
 */
public extension NSObject {
    
    /**
     Transform the current NSObject to JSON.
     
     - Returns: JSON String with data.
     - Throws: If an internal error occurs, upon throws contains an NSError object that describes the problem.
     */
    public func toJSON() throws -> String  {
        let dictionary: [String: AnyObject] = toDictionary()
        let data = try NSJSONSerialization.dataWithJSONObject(dictionary , options: NSJSONWritingOptions(rawValue: 0))
        let jsonString = NSString(data: data, encoding: NSASCIIStringEncoding)
        return jsonString as! String
    }
    
    /**
     Transforms the current NSObject to Dictionary.
     
     - returns: Dictionary with data.
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary = Dictionary<String, AnyObject>()
        
        let propertyAndTypes = self.getPropertiesAndType()
        
        let customKeys: [String : String]? = self.customKeysName()
        
        for (label, _) in propertyAndTypes {
            var customKey = label
            
            if let custom = customKeys?[label] {
                customKey = custom
            }
            
            guard let propertyValue = self.valueForKey(customKey) else {
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
}