Pod::Spec.new do |s|
  s.name = 'SunbeamTimerService'
  s.version = '0.1.5'
  s.summary = 'A simple NSTimer manager for develop.'
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"sunbeamChen"=>"chenxun1990@126.com"}
  s.homepage = 'https://github.com/sunbeamChen/SunbeamTimerService'
  s.source = { :path => '.' }

  s.ios.deployment_target    = '7.0'
  s.ios.preserve_paths       = 'ios/SunbeamTimerService.framework'
  s.ios.public_header_files  = 'ios/SunbeamTimerService.framework/Versions/A/Headers/*.h'
  s.ios.resource             = 'ios/SunbeamTimerService.framework/Versions/A/Resources/**/*'
  s.ios.vendored_frameworks  = 'ios/SunbeamTimerService.framework'
end
