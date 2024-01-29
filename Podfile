# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

install! 'cocoapods',
         :deterministic_uuids => false,
         :disable_input_output_paths => true #fix dSym issue https://github.com/CocoaPods/CocoaPods/issues/9185


# ignore all warnings from all pods
inhibit_all_warnings!

# supportet swift versions
supports_swift_versions '>= 5.0'

target 'SternXTask' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireNetworkActivityIndicator'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt'
  pod 'Charts'
  pod 'RxDataSources'
  pod 'CocoaLumberjack/Swift'
  pod 'SwiftLint', '0.50.1'
  pod 'PureLayout'
  pod 'Hero'
  
  # Pods for SternXTask
  target 'SternXTaskTests' do
    inherit! :search_paths
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Nimble'
    # Pods for testing
  end
end

post_install do |installer|

  installer.pods_project.build_configurations.each do |config|
    config.build_settings["CLANG_ENABLE_CODE_COVERAGE"] = 'NO'
    config.build_settings['ENABLE_CODE_COVERAGE'] = 'NO'
  end
  # this code for make resolve waring that be noticed by xcode 12.
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
