
Pod::Spec.new do |s|
  s.name         = "RNPalette"
  s.version      = "1.0.0"
  s.summary      = "RNPalette"
  s.description  = <<-DESC
                  RNPalette
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "jeral17@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/jerson/react-native-palette-full.git", :tag => "master" }
  s.source_files  = "RNPalette/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  