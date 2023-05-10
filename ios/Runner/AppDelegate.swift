import CoreMotion
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
		let motion = CMMotionManager()

		override func application(
				_ application: UIApplication,
				didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
		) -> Bool {
				GeneratedPluginRegistrant.register(with: self)
				startGyro()
				return super.application(application, didFinishLaunchingWithOptions: launchOptions)
		}

		func startGyro() {
				if motion.isDeviceMotionAvailable {
						motion.deviceMotionUpdateInterval = 0.05
						motion.startDeviceMotionUpdates(to: .main) { (data: CMDeviceMotion?, error) in
								if let gravity = data?.gravity {
										print(gravity.x)
										print(gravity.y)
								}
						}
				}
		}
		
		func stopGyro() {
				if(motion.isDeviceMotionActive){
						motion.stopDeviceMotionUpdates()
				}
		}
}
