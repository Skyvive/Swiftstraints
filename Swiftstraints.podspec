Pod::Spec.new do |s|
  s.name         = "Swiftstraints"
  s.version      = "1.0.0"
  s.summary      = "Auto Layout In Swift Made Easy"
  s.description  = <<-DESC
                   Auto layout can be a pain. But it doesn't have to be.
                   Swiftstraints makes it easy to write layout constraints in one line of code.
                   DESC
  s.homepage     = "https://github.com/Skyvive/Swiftstraints"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad.hilton.nw@gmail.com" }
  s.source       = { :git => "https://github.com/Skyvive/Swiftstraints.git", :tag => "1.0.0" }
  s.ios.deployment_target = "8.0"
  s.source_files  = "Swiftstraints", "Swiftstraints/**/*.{swift,h,m}"
  s.requires_arc = true
end
