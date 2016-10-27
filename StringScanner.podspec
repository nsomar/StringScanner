Pod::Spec.new do |s|
  s.name             = "StringScanner"
  s.version          = "0.1.0"
  s.summary          = "`StringScanner` is a native swift implementation of a string scanner; a replacement of `NSScanner`."
  s.description      = <<-DESC
  `StringScanner` is a native swift implementation of a string scanner; a replacement of `NSScanner`. 

`StringScanner` has been built by using swfit standard library only, and it does not depend on libFoundation. In that way it can be built on mac and linux, and can be build with static compilation in mind.

                       DESC
  s.homepage         = "https://github.com/oarrabi/StringScanner"
  s.license          = 'MIT'
  s.author           = { "Omar Abdelhafith" => "o.arrabi@me.com" }
  s.source           = { :git => "https://github.com/oarrabi/StringScanner.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9' 
  s.requires_arc = true

  s.source_files = 'Sources/*'
end