
Pod::Spec.new do |s|
  s.name             = 'SimpleStoreData'
  s.version          = '0.1.0'
  s.summary          = 'Swift编写的数据存储简化(暂时只有存储到UserDefault)'

  s.description      = <<-DESC
SimpleStoreData一个纯Swift的框架, 为了更简单、更结构化地存储和读写数据, 提供多种数据存储方式选择(暂时只有UserDefault)。
                       DESC

  s.homepage         = 'https://github.com/skytoup/SimpleStoreData'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'skytoup' => 'skytoupone1@gmail.com' }
  s.source           = { :git => 'https://github.com/skytoup/SimpleStoreData.git', :tag => s.version.to_s }

  s.swift_version = '5.1'
  s.swift_version = ['5.1', '5.2']

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.13'
  s.watchos.deployment_target = '5.0'

  s.source_files = 'SimpleStore/**/*.swift'

  s.frameworks = 'Foundation'
end
