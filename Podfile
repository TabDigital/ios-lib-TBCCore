workspace 'TBCCore'
xcodeproj 'Tests/TBCCore Tests.xcodeproj'

platform :ios, "5.1"

def import_pods
    pod 'TBCCore', :path => './'
end

target 'iOS Tests' do
    import_pods
end

target 'OS X Tests' do
    platform :osx, "10.9"
    import_pods
end

target 'TBCCore Example' do
    xcodeproj 'Example/TBCCore Example.xcodeproj'
    import_pods
end

target 'TBCCore ExampleTests' do
    xcodeproj 'Example/TBCCore Example.xcodeproj'
    import_pods
end
