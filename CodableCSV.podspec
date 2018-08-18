
Pod::Spec.new do |s|
  s.name             = 'CodableCSV'
  s.version          = '0.1.0'
  s.summary          = 'CodableCSV allows you to encode and decode CSV files using Codable model types.'

  s.description      = <<-DESC
                       DESC

  s.homepage         = 'https://github.com/pauljohanneskraft/CodableCSV'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pauljohanneskraft' => 'pauljohanneskraft@icloud.com' }
  s.source           = { :git => 'https://github.com/pauljohanneskraft/CodableCSV.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CodableCSV/Classes/**/*'
end
