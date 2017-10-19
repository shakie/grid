# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Q42Grid' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Q42Grid
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'

  def testing_pods
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
    pod 'RxBlocking'
  end

  target 'Q42GridTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  target 'Q42GridUITests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == '<insert target name of your pod here>'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
  end

end
