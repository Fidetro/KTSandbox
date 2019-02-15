
Pod::Spec.new do |s|



  s.name         = "KTSandbox"
  s.version      = "0.0.2"
  s.summary      = "iOS sandbox debug tool."
  s.homepage     = "https://github.com/Fidetro/KTSandbox"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "fidetro" => "zykzzzz@hotmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Fidetro/KTSandbox.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.{swift}"
  s.dependency "File","~> 0.0.1"


end
