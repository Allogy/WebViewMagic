Pod::Spec.new do |s|
  version = "0.0.2"

  s.name         = "WebViewMagic"
  s.version      = version
  s.summary      = "WebViewMagic adds miscellaneous helpers UIWebViews."
  s.homepage     = "http://allogy.com/WebViewMagic"

  s.license      = {
    :type => 'Allogy Interactive',
    :text => <<-LICENSE
              Copyright (c) 2012 Allogy Interactive. All rights reserved.
    LICENSE
  }

  s.author       = { "Richard Venable" => "richard@epicfox.com" }
  s.source       = { :git => "https://github.com/Allogy/WebViewMagic.git", :tag => 'v' + s.version.to_s }
  s.platform     = :ios, '6.0'
  s.source_files = 'WebViewMagic/**/*.{h,m}'
  s.framework  = 'Foundation', 'UIKit'
  s.requires_arc = true

end
