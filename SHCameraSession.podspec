Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "SHCameraSession"
  s.version      = "0.0.1"
  s.summary      = "Configure the camera of a device by the AVFoundation framework."

  s.description  = "Configure the camera of a device by the AVFoundation framework.
                    Because this class is abstract,
                    please use the concrete subclasses SHCaptureCameraSession and
                    SHVideoCameraSession instead of this class."

  s.homepage     = "https://github.com/ShengHuaWu/SHCameraSession"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author             = { "ShengHua Wu" => "fantasy0404@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "7.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source       = { :git => "https://github.com/ShengHuaWu/SHCameraSession.git", :tag => "#{s.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #s

  s.source_files  = "SHCameraSession/Classes/*.{h,m}"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.frameworks = "AVFoundation"

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true

end
