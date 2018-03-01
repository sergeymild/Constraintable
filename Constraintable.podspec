Pod::Spec.new do |s|
  s.name             = 'Constraintable'
  s.version          = '0.1.0'
  s.summary          = 'Simplefied Achors'
 
  s.description      = <<-DESC
Simplefied Achors
                       DESC
 
  s.homepage         = 'https://github.com/sergeymild/Constraintable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sergeymild' => 'sergeymild@yandex.ru' }
  s.source           = { :git => 'https://github.com/sergeymild/Constraintable.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Constraintable/Constraintable.swift'
 
end
