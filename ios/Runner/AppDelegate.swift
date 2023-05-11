import Flutter
import streams_channel
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
		
		var handler: StreamHandler = StreamHandler()
		
		override func application(
				_ application: UIApplication,
				didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
		) -> Bool {
				GeneratedPluginRegistrant.register(with: self)
				let controller = window.rootViewController as! FlutterBinaryMessenger
				let channel = FlutterStreamsChannel(
								name: "stream_channel_devices", binaryMessenger: controller)
				channel.setStreamHandlerFactory({ (ar) in
								return self.handler
				})
				return super.application(application, didFinishLaunchingWithOptions: launchOptions)
		}
}
