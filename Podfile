# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

  #use_frameworks!

  target 'DSG' do
   use_frameworks!

  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  pod 'AlamofireImage'
  pod 'Nuke-Alamofire-Plugin'
  pod 'Alamofire'
  pod 'MBProgressHUD'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end
