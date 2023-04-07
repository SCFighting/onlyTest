# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'onlyTest' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'CocoaLumberjack'
  pod 'SDWebImage'
  pod 'YYImage/WebP'
  pod 'SDWebImageWebPCoder'
  pod 'MJExtension'
  pod 'MBProgressHUD'
  pod 'IQKeyboardManager'
  pod 'WebViewJavascriptBridge'
  pod 'MJRefresh'
  pod 'CHTCollectionViewWaterfallLayout'
  pod 'TZImagePickerController'
  pod 'AFNetworking', '~> 4.0.1'
  pod 'TXLiteAVSDK_Professional'
  pod 'SuperPlayer/Professional'
  pod 'TXIMSDK_Plus_iOS'
  pod 'BlocksKit'
  pod 'KVOController'
  target 'onlyTestUITests' do
    # Pods for testing
  end
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
  end
end
