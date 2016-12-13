Pod::Spec.new do |s|
    s.name         = 'JM_ActionSheet'
    s.version      = '1.0.0'
    s.summary      = 'An ActionSheet like WeChat'
    s.homepage     = 'https://github.com/ZJM6658/ActionSheetLikeWeChat'
    s.license      = 'MIT'
    s.authors      = {'JM Zhu' => '815187811@qq.com'}
    s.platform     = :ios, '6.0'
    s.source       = {:git => 'https://github.com/ZJM6658/ActionSheetLikeWeChat.git', :tag => s.version}
    s.source_files = 'JM_ActionSheet/*.{h,m}'
    s.requires_arc = true
end