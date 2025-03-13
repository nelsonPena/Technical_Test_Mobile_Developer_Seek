# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Technical_Test_Mobile_Developer_Seek' do
  use_frameworks!
  use_modular_headers!

  flutter_application_path = 'flutter_module'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

  install_all_flutter_pods(flutter_application_path)

  post_install do |installer|
    flutter_post_install(installer)
  end
end