Pod::Spec.new do |s|
  s.name             = 'Transbank'
  s.version          = '1.0.0'
  s.summary          = 'Transbank Module'

  s.description      = <<-DESC
Used to inject the Transbank scene
                       DESC

  s.homepage         = 'https://japanart1234.wixsite.com/jonolivet/ios-developer-info'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kevinOlivet' => 'kevinolivet@yahoo.com' }
  s.source           = { :git => 'ssh://git@github.com/kevinOlivet/Transbank.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.1'

  s.source_files = 'Transbank/Classes/**/*'
  s.resources = [
  'Transbank/Assets/**/*.{storyboard,xib,xcassets,html,json,pdf,otf,ttf,plist,strings}'
  ]

  s.dependency 'BasicCommons'
  s.dependency 'BasicUIElements'
end
