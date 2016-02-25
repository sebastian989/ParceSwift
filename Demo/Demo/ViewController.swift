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
        let apiDictionary = [
            "name": "Brian",
            "age" : 80,
            "user_email": "user@email.com",
            "address": ["street": "Columbus", "avenue":12],
            "height": 1.75,
            "isOld": true,
            "mobile_number": "567-876-2343",
            "anyDictionary": ["key":2],
            "arrayAnyTypes": [1,2,3,4,5],
            "modelsArray": [["street":"sabaneta","avenue":12], ["street":"sabaneta","avenue":13]]
        ]
        
        let user = User()
        user.fromDictionary(apiDictionary)
        
        print("name: \(user.name!), address: Street \(user.address!.street!) Avenue \(user.address!.avenue!)")
        
        // Model to JSON String
        do {
            let jsonString = try user.toJSON()
            print("toJSON: " + jsonString)
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

