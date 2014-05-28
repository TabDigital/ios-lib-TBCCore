Pod::Spec.new do |s|
  s.name         = "TBCCore"
  s.version      = "0.0.1"
  s.summary      = "TBCCore provides useful utilities for development with objective-c on iOS and OS X"
  s.authors      = 'Tabcorp'
  s.license      = 'COMMERCIAL'
  s.homepage     = 'https://github.com/TabDigital/ios-lib-TBCCore'
  s.source       = { :git => "git@github.com:TabDigital/ios-lib-TBCCore.git", :commit => 'master' }

  s.ios.deployment_target = "5.1"
  s.osx.deployment_target = "10.9"
  s.source_files = "TBCCore/**/*.{h,m,c}"
  s.public_header_files =  "TBCCore/**/*.h", "TBCCore/Configuration/Warnings.xh"
  s.private_header_files = "TBCCore/Internal/**/*.h"
  s.preserve_paths = "TBCCore/Configuration/Warnings.xh"
  s.header_mappings_dir = 'TBCCore'
  s.requires_arc = true
  
  # I admit this is cheeky, but it works
  s.xcconfig = { "TBCCORE_WARNINGS_INCLUDED" => "1\n#include \"Headers/TBCCore/Configuration/Warnings.xh\"" }
end
