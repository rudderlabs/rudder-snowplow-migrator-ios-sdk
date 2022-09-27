source 'https://github.com/CocoaPods/Specs.git'
workspace 'RudderSnowplowMigrator.xcworkspace'
use_frameworks!
inhibit_all_warnings!
platform :ios, '9.0'

def shared_pods
    pod 'Rudder', '~> 1.7.0'
end

target 'RudderSnowplowMigrator' do
    project 'RudderSnowplowMigrator.xcodeproj'
    shared_pods
end

target 'SampleAppObjC' do
    project 'Examples/SampleAppObjC/SampleAppObjC.xcodeproj'
    shared_pods
    pod 'RudderSnowplowMigrator', :path => '.'
    pod 'SnowplowTracker', '~> 4.0'
end

target 'SampleAppSwift' do
    project 'Examples/SampleAppSwift/SampleAppSwift.xcodeproj'
    shared_pods
    pod 'RudderSnowplowMigrator', :path => '.'
    pod 'SnowplowTracker', '~> 4.0'
end
