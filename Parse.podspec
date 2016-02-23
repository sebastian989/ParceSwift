Pod::Spec.new do |s|
 
    s.name         = "ContactsManager"
    s.version      = "0.3.3"
    s.summary      = "Obtain and manage your device contacts in a easy way."
    s.homepage     = "https://github.com/Kekiiwaa/ContactsManager"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = "Sebastian Gomez Osorio, Andres Silva Gomez"
    s.source       = { :git => "https://github.com/Kekiiwaa/ContactsManager.git", :tag => "0.3.3" }
    s.source_files = "ContactsManager", "ContactsManager/*.{h,m}"
    s.frameworks   = 'UIKit'
    s.ios.deployment_target = '8.0'
    s.platform = :ios, '7.0'
    s.requires_arc = false
 
end