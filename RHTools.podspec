Pod::Spec.new do |s|
  s.name             = "RHTools"
  s.version          = "0.1.0"
  s.summary          = "RHTools is a collection of useful Objective-C categories and classes."
  s.homepage         = "https://github.com/chriscdn/RHTools"
  s.license          = 'MIT'
  s.author           = { "Christopher Meyer" => "chris@rhouse.ch" }
  s.source           = { :git => "https://github.com/chriscdn/RHTools.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/chriscdn'

  s.ios.deployment_target = '8.3'
  s.requires_arc = true

  s.source_files = 'RHTools/**/*.{h,m}'
  s.resources = 'RHTools/**/*.xib'
  s.dependency 'FrameAccessor'
  
  s.prefix_header_contents = '#import "RHTools.h"'
end
