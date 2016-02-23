# ContactsManager Objective C

## Usage

ContactsManager is a delightful library for iOS. It's built with high quality standards to optimize the performance of your application and get your contacts quickly and safely.

Choose ContactsManager for your next project, or migrate over your existing projects, we guarantee you'll be happy you did!

## How To Get Started

* Download ContactsManager and try out the included iPhone Demo

## Installation

* Using Cocoapods
* Copying all the files into your project

### CocoaPods:
ContactsManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod 'ContactsManager'

After this import ContactsManager: 
```#import "KTSContactsManager.h"```

### Copying files into your project

1. Drag and Drop ContactsManager folder into your project
2. In "Choose options dialog" check "Copy items if needed" and select "Create Groups" option, then press finish Button.
3. In the Class that you want get the device contacts, import ContactsManager: 
```#import "KTSContactsManager.h```

## Usage

### Import All Contacts:
```
self.contactsManager = [KTSContactsManager sharedManager];

[self.contactsManager importContacts:^(NSArray *contacts) {
        NSLog(@"contacts: %@",contacts);
    }];
```

We return a JSON representation from contacts

```
{
        birthday = "1978-01-20 12:00:00 +0000";
        company = "Creative Consulting";
        createdAt = "2008-02-14 01:33:02 +0000";
        department = "";
        emails =         (
                        {
                label = Work;
                value = "kate-bell@mac.com";
            },
                        {
                label = Work;
                value = "www.icloud.com";
            }
        );
        firstName = "";
        firstNamePhonetic = "";
        id = 1;
        jobTitle = Producer;
        lastName = Bell;
        lastNamePhonetic = "";
        middleName = "";
        nickName = "";
        note = "";
        phones =         (
                        {
                label = Mobile;
                value = "(555) 564-8583";
            }
        );
        prefix = "";
        suffix = "";
        updatedAt = "2015-04-25 23:27:46 +0000";
    }
```
### Sort contacts:

```
self.contactsManager.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES] ];
```

### Filter contacts
Implement KTSContactsManagerDelegate in your controller and create delegate function to filter contacts.

```
self.contactsManager.delegate = self;

-(BOOL)filterToContact:(NSDictionary *)contact
{
    return ![contact[@"company"] isEqualToString:@""];
}
```

### Contact change while application is in use
Add method from delegate and listen when any contact change.

```
self.contactsManager.delegate = self;

-(void)addressBookDidChange
{
    NSLog(@"Address Book Change");
}
```

### Add new Contact
```
[self.contactsManager addContactName: @"Tefany"
                              lastName: @"Jhonson"
                                phones: @[@{@"label":@"mobile",@"value":@"731782982"}]
                                emails: @[@{@"label":@"work",@"value":@"tefany@work.com"}]
                              birthday: nil completion:^(BOOL wasAdded) {
                                  
        NSLog(@"%i",wasAdded);
                                  
    }];
```

### Remove Contact
```
[self.contactsManager removeContactById:184 completion:^(BOOL wasRemoved) {
        NSLog(@"%i",wasRemoved);
    }];
```

## Author

Kekiiwaa Inc, 
[Sebastian Gomez Osorio](https://github.com/sebastian989),
[Andres Silva Gomez](https://github.com/andresilvagomez)

## License

ContactsManager is available under the MIT license. See the LICENSE file for more info.

