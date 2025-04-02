#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint get_settings.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'get_settings'
  s.version          = '1.0.7'
  s.summary          = 'Get Settings'
  s.description      = <<-DESC
Get Settings.
                       DESC
  s.homepage         = 'https://github.com/biner88/get_settings'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Sumsg' => 'sumsg@outlook.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'get_settings_privacy' => ['get_settings/Sources/get_settings/PrivacyInfo.xcprivacy']}
end
