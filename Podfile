# Uncomment the next line to define a global platform for your project
 platform :ios, '13.4'

target 'OptimalHealth' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OptimalHealth Indonesia

pod 'Alamofire', '4.9.1'
pod 'AlamofireImage', '3.6.0'
pod 'IQKeyboardManagerSwift'
pod 'GoogleMaps'
pod 'SwiftyJSON'
pod 'DatePickerDialog'
pod 'SDWebImage'
pod 'RSKImageCropperSwift' , '>= 1.5.1.swift3'
pod 'ImageScrollView'
pod 'CryptoSwift'
pod 'FloatRatingView'
pod 'KMPlaceholderTextView'
pod 'SVProgressHUD'
pod 'GrowingTextView'

pod 'SWXMLHash','= 5.0.1'
pod 'JitsiMeetSDK', '~> 9.0.1'
pod 'Firebase/Crashlytics'
pod 'Firebase/Analytics'
pod 'Firebase/Performance'
pod 'DropDown'
pod 'QiscusMultichannelWidget', '~> 2.3.3'

#@ade: start
#pod 'JSONWebToken'
#@ade: end

  target 'OptimalHealthTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OptimalHealthUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
  
  post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "13.4"
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end




