#
# Be sure to run `pod lib lint LEGOPhotosManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LEGOPhotosManager'
  s.version          = '0.1.5'
  s.summary          = 'Photo management tool, you can get album list, photo list, save photos, delete photos, get photos by iCloud, cancel photo request  照片管理工具，可以获取相册列表、照片列表，保存照片、删除照片，通过 iCloud 获取照片，取消照片请求'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/legokit/LEGOPhotosManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '564008993@qq.com' => 'yangqingren@yy.com' }
  s.source           = { :git => 'https://github.com/legokit/LEGOPhotosManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LEGOPhotosManager/Classes/**/*'
  
  s.dependency 'Masonry'
  
  # s.resource_bundles = {
  #   'LEGOPhotosManager' => ['LEGOPhotosManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
