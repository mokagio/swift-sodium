Pod::Spec.new do |s|
  s.name = 'Sodium-Fork'
  s.version = '0.8.1'
  s.license = { :type => "ISC", :file => 'LICENSE' }
  s.summary = 'A temporary fork of Swift-Sodium to workaround a CocoaPods validation issue'
  s.description = <<-DESC
                     There is an issue with the Sodium.podspec when working with the Xcode 12 toolchain due the build setting changes in preparation for Apple Silicon.
                     If you use Sodium as a consumer, you can work around it in the the `Podfile`, but if Sodium is one of the dependencies of your pod, it will fail to pass the `pod spec lint` validation until the fix is pushed upstream.

                     In the meantime, you can use this fork in your `.podspec`:

                     ```diff
                     - spec.dependency "Sodium"
                     + spec.dependency "Sodium-Fork", "0.8.1"
                     ```
  DESC
  s.homepage = 'https://github.com/mokagio/swift-sodium'
  s.social_media_url = 'https://twitter.com/mokagio'
  s.authors = { 'Frank Denis' => '' }
  s.source = { :git => 'https://github.com/mokagio/swift-sodium.git',
               :tag => '0.8.1' }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '5.0'

  s.ios.vendored_library     = 'Sodium/libsodium/libsodium-ios.a'
  s.osx.vendored_library     = 'Sodium/libsodium/libsodium-osx.a'
  s.watchos.vendored_library = 'Sodium/libsodium/libsodium-watchos.a'

  s.source_files = 'Sodium/**/*.{swift,h}'
  s.private_header_files = 'Sodium/libsodium/*.h'

  s.preserve_paths = 'Sodium/libsodium/module.modulemap'

  # Xcode 12 changed the way apps are built because of the upcoming support for
  # Apple Silicon. We need explicitly exclude the arm64 architecture.
  # More info at
  # https://stackoverflow.com/questions/63607158/xcode-12-building-for-ios-simulator-but-linking-in-object-file-built-for-ios
  s.pod_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS' => '$(PODS_TARGET_SRCROOT)/Sodium/libsodium',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=watchsimulator*]' => 'arm64',
  }

  # Notice that a CocoaPods contributor discourages the use of
  # `user_target_xcconfig`, but in this case also agrees that there might not be
  # a better approach.
  # See
  # https://github.com/CocoaPods/CocoaPods/issues/10065#issuecomment-701055569
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=watchsimulator*]' => 'arm64',
  }

  s.requires_arc = true
end
