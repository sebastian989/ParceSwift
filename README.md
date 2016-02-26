# ParceSwift

## Usage

ParceSwift is a delightful library for iOS specifically Swift. It's built with high quality standards to parse dictionaries to models quickly and safely.

Choose ParceSwift for your next project, or migrate over your existing projects, we guarantee you'll be happy you did!

## How To Get Started

* Download ParceSwift and try out the included iPhone Demo

## Installation

* Using Cocoapods
* Copying all the files into your project

### CocoaPods:

ParceSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'ParceSwift'

### Copying files into your project

1. Drag and Drop ParceSwift folder into your project
2. In "Choose options dialog" check "Copy items if needed" and select "Create Groups" option, then press finish Button.

## Usage

First you need to import ParceSwift in AppDelegate or where you want:
```
import ParceSwift
```

#### Important things

* All your models that you want to Map must inherit of NSObject.
* If you have properties of type Int, Float or Double then you must change these types to NSNumber.
* If you have properties of type Bool, you must initialize these in their declaration.

### Get a model from dictionary:

ParceSwift is an extension of NSObject, all you need to do is create a new object and start to transform a dictionary to any classes.

Let's assume that you have some JSON like that:
```
{
    "name": "Brian",
    "age": 26,
    "height": 1.75,
    "isOld": true,
    "user_email": "user@email.com",
    "mobile_number": "567-876-2343",
    "address": {
        "street": "Columbus",
        "avenue": 12
    },
    "anyDictionary": {
        "key": 2
    },
    "arrayAnyTypes": [1, 2, 3, 4, 5],
    "modelsArray": [{
        "street": "sabaneta",
        "avenue": 12
    }, {
        "street": "sabaneta",
        "avenue": 13
    }]
}
```

And your User model looks like:
```
class User: NSObject {
    var name: String?
    var age: NSNumber?
    var height: NSNumber!
    var isOld: Bool = false
    var email: String?
    var cellphone: String?
    var address: Address?
    var anyDictionary: [String:Int]?
    var arrayAnyTypes: [Int]?
    var modelsArray: [Address]?
}
```

As you can see, this model has a property called address, this property is of type Address which is a class like this:
```
class Address : NSObject {
    var street: String?
    var avenue: NSNumber?
}
```

Using any JSON parser you need to transform this NSString to a NSDictionary representation:
```
var error: NSError?
var data = jsonData.dataUsingEncoding(NSUTF8StringEncoding)
do{
    var dataDictionary: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
} catch {
    
}
```

Next you have to create an object and call 'fromDictionary' function passing the dictionary in the parameters:
```
let user = User()
user.fromDictionary(dataDictionary)
```

Then you can use the model properties and functions:
```
print(user.name!)
print(user.address!.street!)
```

### Mapping JSONArray to models Array

Let`s supose that you have an array of dictionaries like this:
```
let array = [["street":"sabaneta","avenue":12], ["street":"sabaneta","avenue":13]]
```

You can get a models array in a simple way just calling 'fromJsonArray' function and passing the array in their parameters:
```
let modelsArray: [Address] = Address.fromJsonArray(array)
```

To use 'fromJsonArray' function you don't need to instance the class, just call it from your model class.

### Overriding Key Name for Attribute

If your JSON have any key that doesn't match with the model property name, you can override the function 'customKeysName' in the model to map this key to the attribute. You have to return a dictionary with the model property name and the name that will receive in the json:
```
override func customKeysName() -> [String : String]? {
    let customs = [
            "email": "user_email",
            "cellphone": "mobile_number"
    ]
    return customs
}
```

### Get a model from JSON String:

The same process but you must use 'fromJSON' function.

```
do{
    let jsonString = "{\"name\": \"Jose\",\"age\": 25,\"address\": {\"street\": \"Cupertino\",\"avenue\": 15},\"height\": 1.64,\"isMan\": true,\"anyDictionary\": {\"key\": 2},\"arrayAnyTypes\": [1, 2, 3, 4, 5],\"modelsArray\": [{\"street\": \"Medellín\",\"avenue\": 10}, {\"street\": \"Medellín\",\"avenue\": 11}]}"
    let userJ = User()
    try userJ.fromJSON(jsonString)

    print("name: \(userJ.name!), address: Street \(userJ.address!.street!) Avenue \(userJ.address!.avenue!)")
} catch {
    print("The string isn't a valid JSON")
}
```

Must use try catch blocks to do error handling.


### Create a dictionary from a model:

If your model and sub models extends of NSObject:

```
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
```

```
class Address: NSObject {
    var street: String?
    var avenue: NSNumber?
    
    init(street: String, avenue: NSNumber) {
        super.init()
        self.street = street
        self.avenue = avenue
    }
}
```

And it's initialized:

```
let homeAddress = Address(street: "Columbus", avenue: 12)
let workAddress = Address(street: "Sabaneta", avenue: 13)
let marketAddress = Address(street: "Cupertino", avenue: 15)

let user = User()
user.name = "Brian"
user.age = 26
user.address = homeAddress
user.height = 1.75
user.isMan = true
user.anyDictionary = ["key": 2]
user.arrayAnyTypes = [1, 2, 3, 4, 5]
user.modelsArray = [workAddress, marketAddress]
```

Create a dictionary from your model it's simply like:

```
let myDictionary: [String: AnyObject] = user.toDictionary()
```

### Create a JSON String from a model:

The same process but you must use 'fromJSON' function.
```
do {
    let jsonString = try user.toJSON()
    print("toJSON: " + jsonString)
} catch {
    print("The model can't be parsed to JSON format")
}
```

## Author

[Sebastián Gómez Osorio](https://github.com/sebastian989),
[Leonardo Armero Barbosa](https://github.com/xrax)

## License

ContactsManager is available under the MIT license. See the LICENSE file for more info.

