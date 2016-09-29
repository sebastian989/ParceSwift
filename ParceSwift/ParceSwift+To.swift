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
    public func toJSON() throws -> String? {
        let dictionary: [String: AnyObject] = toDictionary()
//        if !JSONSerialization.isValidJSONObject(dictionary) {
//            return nil
//        }
        let data = try JSONSerialization.data(withJSONObject: dictionary , options: [])
        let jsonString = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
        return jsonString as? String
    }
    
    /**
     Transforms the current NSObject to Dictionary.
     
     - returns: Dictionary with data.
     */
    public func toDictionary() -> [String: AnyObject] {
        var dictionary = Dictionary<String, AnyObject>()
        
        let propertyAndTypes = self.getPropertiesAndType()
        
        for (label, _) in propertyAndTypes {
            
            guard let propertyValue = self.value(forKey: label) else {
                continue
            }
            
            if propertyValue is String
            {
                dictionary[label] = propertyValue as! String as AnyObject?
            }
                
            else if propertyValue is NSNumber
            {
                dictionary[label] = propertyValue as! NSNumber
            }
                
            else if propertyValue is Array<String>
            {
                dictionary[label] = propertyValue as AnyObject?
            }
                
            else if propertyValue is Array<AnyObject>
            {
                var array = Array<[String: AnyObject]>()
                
                for item in (propertyValue as! Array<AnyObject>) {
                    array.append(item.toDictionary())
                }
                
                dictionary[label] = array as AnyObject?
            }
                // AnyObject
            else
            {
                dictionary[label] = (propertyValue as AnyObject).toDictionary() as AnyObject
            }
        }
        return dictionary
    }    
}
