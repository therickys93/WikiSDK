#
# Be sure to run `pod lib lint WikiSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WikiSDK'
  s.version          = '0.1.0'
  s.summary          = 'WikiSDK per il progetto Wiki.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Semplice API scritta in Swift per il progetto Wiki.
                       DESC

  s.homepage         = 'https://github.com/therickys93/WikiSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'therickys93' => 'therickys93@gmail.com' }
  s.source           = { :git => 'https://github.com/therickys93/WikiSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version         = '4.2'
  s.ios.deployment_target = '8.0'

  s.source_files = 'WikiSDK/Classes/**/**/*'
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
