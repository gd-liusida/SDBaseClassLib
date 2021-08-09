#
# Be sure to run `pod lib lint SDBaseClassLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDBaseClassLib'
  s.version          = '1.1.0'
  s.summary          = '常用类方法和Swift版本的一个扩展'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '这是常用方法和Swift版本扩展的一个详细的使用，可以参考里面的用法'

  s.homepage         = 'https://github.com/gd-liusida/SDBaseClassLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gd-liusida' => '1163149842@qq.com' }
  s.source           = { :git => 'https://github.com/gd-liusida/SDBaseClassLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_versions   = '5.0'
  s.platform         = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  
  # 要求是ARC
  s.requires_arc = true

  s.source_files = 'SDBaseClassLib/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SDBaseClassLib' => ['SDBaseClassLib/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'MBProgressHUD'
end
