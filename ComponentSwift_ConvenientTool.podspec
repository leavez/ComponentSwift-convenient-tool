
Pod::Spec.new do |s|
  s.name             = 'ComponentSwift_ConvenientTool'
  s.version          = '0.1'
  s.summary          = 'Convenient tool for ComponentSwift.'


  s.description      = <<-DESC
Convenient tool for ComponentSwift.
        DESC

  s.homepage         = 'https://github.com/leavez/ComponentSwift-convenient-tool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leavez' => 'gaojiji@gmail.com' }
  s.source           = { :git => 'https://github.com/leavez/ComponentSwift-convenient-tool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.1'

  s.dependency 'ComponentSwift'
  s.default_subspecs = 'ImageDownloader', 'Components'


  s.subspec 'ImageDownloader' do |sp|
      sp.source_files = 'Classes/ImageDownloader/**/*.{h,m,mm,swift}'
      sp.dependency 'SDWebImage', '~> 4.0'
  end

  s.subspec 'Components' do |sp|
      sp.source_files = 'Classes/Components/**/*.{h,m,mm,swift}'
      sp.private_header_files = 'Classes/Components/inner/**/*.h'
      sp.dependency "ComponentSwift_ConvenientTool/ImageDownloader"
  end

end
