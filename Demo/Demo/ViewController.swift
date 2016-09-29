//
//  ViewController.swift
//  Demo
//
//  Created by Sebastian Gomez on 23/02/16.
//
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Api response Mock
        let apiDictionary: [String : AnyObject] = [
            "name": "Brian" as AnyObject,
            "age" : 80 as AnyObject,
            "user_email": "user@email.com" as AnyObject,
            "address": ["street": "Columbus", "avenue":12] as AnyObject,
            "height": 1.75 as AnyObject,
            "isOld": true as AnyObject,
            "mobile_number": "567-876-2343" as AnyObject,
            "anyDictionary": ["key":2] as AnyObject,
            "arrayAnyTypes": [1,2,3,4,5] as AnyObject,
            "modelsArray": [["street":"sabaneta","avenue":12], ["street":"sabaneta","avenue":13]] as AnyObject
        ]
        
        let jsonArray: [Address] = Address.fromJsonArray([["street":"sabaneta" as AnyObject,"avenue":12 as AnyObject], ["street":"sabaneta" as AnyObject,"avenue":13 as AnyObject]])
        print("array of models: \(jsonArray)")
        
        let user = User()
        user.fromDictionary(apiDictionary as [String : AnyObject])
        
        print("name: \(user.name!), address: Street \(user.address!.street!) Avenue \(user.address!.avenue!)")
        
        // Model to JSON String
        do {
            let jsonString = try user.toJSON()
            print("toJSON: " + jsonString!)
        } catch {
            print("The model can't be parsed to JSON format")
        }
        
        // JSON String to Model
        do{
            let jsonString = "{\"name\": \"Jose\",\"age\": 25,\"address\": {\"street\": \"Cupertino\",\"avenue\": 15},\"height\": 1.64,\"isMan\": true,\"anyDictionary\": {\"key\": 2},\"arrayAnyTypes\": [1, 2, 3, 4, 5],\"modelsArray\": [{\"street\": \"Medellín\",\"avenue\": 10}, {\"street\": \"Medellín\",\"avenue\": 11}]}"
            let userJ = User()
            try userJ.fromJSON(jsonString)
        } catch {
            print("The string isn't a valid JSON")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

