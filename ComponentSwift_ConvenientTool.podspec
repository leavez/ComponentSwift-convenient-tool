
Pod::Spec.new do |s|
  s.name             = 'ComponentSwift_ConvenientTool'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ComponentSwift-convenient-tool.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gaojiji@gmail.com/ComponentSwift-convenient-tool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leavez' => 'gaojiji@gmail.com' }
  s.source           = { :git => 'https://github.com/leavez/ComponentSwift-convenient-tool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.1'

  #s.source_files = 'Classes/**/*'

  # s.resource_bundles = {
  #   'ComponentSwift-convenient-tool' => ['ComponentSwift-convenient-tool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'ComponentSwift'
  s.default_subspecs = 'ImageDownloader', 'Components'


  s.subspec 'ImageDownloader' do |sp|
      sp.source_files = 'Classes/ImageDownloader/**/*.{h,m,mm,swift}'
      sp.dependency 'SDWebImage', '~> 4.0'
  end

  s.subspec 'Components' do |sp|
      sp.source_files = 'Classes/Components/**/*.{h,m,mm,swift}'
      sp.private_header_files = 'Classes/Components/inner/**/*.h'
  end

end
