#
# Be sure to run `pod lib lint IBDesignable.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "IBDesignable"
  s.version          = "0.2.0"
  s.summary          = "Simple Interface attributes on standard Cocoa views."
  s.description      = <<-DESC
                            A set of *Objective-C categories* that implement simple attributes on standard Cocoa views.

							By using Objective-C and Cocoa magic, all IBDesignable properties show up in Interface Builder.

                            NOTE: you should use the `use_frameworks!` command in your Podfile.
                       DESC
  s.homepage         = "https://github.com/rjstelling/IBDesignable"
  s.screenshots     = "http://raw.githubusercontent.com/rjstelling/ibdesignable/assets/Screen%20Shots/simulator.png", "http://raw.githubusercontent.com/rjstelling/ibdesignable/assets/Screen%20Shots/xcode.png"
  s.license          = 'MIT'
  s.author           = { "Richard Stelling" => "richard@empiricalmagic.com" }
  s.source           = { :git => "https://github.com/rjstelling/IBDesignable.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rjstelling'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'IBDesignable' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
