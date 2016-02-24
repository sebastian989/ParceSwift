# ParceSwift

## Usage

ParceSwift is a delightful library for iOS. It's built with high quality standards to parse their dictionaries modelsquickly and safely.

Choose ParceSwift for your next project, or migrate over your existing projects, we guarantee you'll be happy you did!

## How To Get Started

* Download ParceSwift and try out the included iPhone Demo

## Installation

* Using Cocoapods
* Copying all the files into your project

### CocoaPods:
ContactsManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'ParceSwift'

### Copying files into your project

1. Drag and Drop ParceSwift folder into your project
2. In "Choose options dialog" check "Copy items if needed" and select "Create Groups" option, then press finish Button.

## Usage

### Get a model from dictionary:

ParceSwift is an extension of NSObject, all you need to do is create a new object and start to transform a dictionary to any classes.

Let's assume that you have some JSON like that:
```
{
    "name": "Brian",
    "age": 26,
    "address": {
        "street": "Columbus",
        "avenue": 12
    },
    "height": 1.75,
    "isMan": true,
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
    var isMan: Bool = false
    var address: Address?
    var anyDictionary: [String:Int]?
    var arrayAnyTypes: [Int]?
    var modelsArray: [Address]?
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

Next you have to create an object and call 'fromDictionary' function:
```
let user = User()
user.fromDictionary(dataDictionary)
```

Then you can use the model properties and functions:
```
print(user.name!)
print(user.address!.street!)
```


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
    var avenue: Int?
    
    init(street: String, avenue: Int) {
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

let myDictionary: [String: AnyObject] = user.toDictionary()




## Author

[Sebastian Gomez Osorio](https://github.com/sebastian989),
[Leonardo Armero Barbosa](https://github.com/xrax)

## License

ContactsManager is available under the MIT license. See the LICENSE file for more info.

