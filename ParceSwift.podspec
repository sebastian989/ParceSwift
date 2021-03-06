Pod::Spec.new do |s|
 
    s.name         = "ParceSwift"
    s.version      = "0.1.0"
    s.summary      = "Parser - Transform from Dictionary to a desired object and the other way."
    s.homepage     = "https://github.com/sebastian989/ParceSwift"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = "Leonardo Armero Barbosa, Sebastián Gómez Osorio"
    s.source       = { :git => "https://github.com/sebastian989/ParceSwift.git", :tag => "0.1.0" }
    s.source_files = "ParseSwift", "ParceSwift/*.{swift}"
    s.frameworks   = 'UIKit'
    s.ios.deployment_target = '8.0'
    s.platform = :ios, '8.0'
    s.requires_arc = false
 
end
