# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

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
  pod 'IAPHelper'
  pod 'MBProgressHUD'
  pod 'CHTCollectionViewWaterfallLayout'
  pod 'TZImagePickerController'
  pod 'AFNetworking', '~> 4.0.1'
  pod 'TXLiteAVSDK_Professional', '=11.3.14333'
  pod 'SuperPlayer/Professional', '=3.7.5'
  pod 'TXIMSDK_Plus_iOS'
  pod 'BlocksKit'
  pod 'KVOController'
  target 'onlyTestUITests' do
    # Pods for testing
  end
  post_integrate do |installer|
    compiler_flags_key = 'COMPILER_FLAGS'
    project_path = 'Pods/Pods.xcodeproj'

    project = Xcodeproj::Project.open(project_path)
    project.targets.each do |target|
      target.build_phases.each do |build_phase|
        if build_phase.is_a?(Xcodeproj::Project::Object::PBXSourcesBuildPhase)
          build_phase.files.each do |file|
            if !file.settings.nil? && file.settings.key?(compiler_flags_key)
              compiler_flags = file.settings[compiler_flags_key]
              file.settings[compiler_flags_key] = compiler_flags.gsub(/-DOS_OBJECT_USE_OBJC=0\s*/, '')
            end
          end
        end
      end
      target.build_configurations.each do |config|
        config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "11.0"
      end
    end
    project.save()
  end
end
