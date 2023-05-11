//
//  StreamHandler.swift
//  Runner
//
//  Created by Saul Mestanza on 11/5/23.
//


import Foundation
import CoreMotion
import streams_channel


class StreamHandler:NSObject, FlutterStreamHandler  {
    let motion = CMMotionManager()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        if let arguments = arguments {
            switch arguments as! String {
            case "start_gyro":
                startGyro(eventSink: events)
            case "stop_gyro":
                stopGyro()
                events(FlutterEndOfEventStream)
            default:
                print("default")
                events(FlutterEndOfEventStream)
            }
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        if let arguments = arguments {
            print("StreamHandler - onCancel: \(arguments)")
        }
        return nil
    }
    
    func startGyro(eventSink events: FlutterEventSink?) {
        if motion.isDeviceMotionAvailable {
                motion.deviceMotionUpdateInterval = 0.5
                motion.startDeviceMotionUpdates(to: .main) { (data: CMDeviceMotion?, error) in
                        if let gravity = data?.gravity {
                            let data: [String: Any] = [
                                "x": gravity.x,
                                "y": gravity.y
                            ]
                            if events != nil {
                                print(data)
                                events!(data)
                            }
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
