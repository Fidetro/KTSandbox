
Pod::Spec.new do |s|



  s.name         = "SwiftFFDB"
  s.version      = "0.0.1"
  s.summary      = "iOS sandbox debug tool."
  s.homepage     = "https://github.com/Fidetro/KTSandbox"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/KTSandbox.git", :tag => "0.0.1" }
  s.source_files  = "Sources/*.{swift}"
  s.dependency "File","~> 0.0.1"


end
