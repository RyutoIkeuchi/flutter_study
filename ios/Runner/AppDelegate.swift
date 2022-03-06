import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name:"sample.flutter.dev",binaryMessenger:controller.binaryMessenger)


    methodChannel.setMethodCallHandler({
      (call:FlutterMethodCall,result:@escaping FlutterResult) -> Void in
        
        switch call.method {
        case "getBatteryLevel":
            self.receiveBatteryLevel(result: result)
        case "getCamera":
            self.receiveCamera(result:result,controller:controller)
        case "getViewController":
            let nextController = controller.storyboard?.instantiateViewController(withIdentifier: "NativeViewController")
            controller.present(nextController!,animated: true,completion: nil)
        default:
            result(FlutterMethodNotImplemented)
            return
        }

    })

    GeneratedPluginRegistrant.register(with: self)  
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func receiveBatteryLevel(result:FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code:"UNAVAILABLE",message:"Battey info unavailable",details:nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
    
    private func receiveCamera(result:FlutterResult,controller:FlutterViewController) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        controller.present(pickerController,animated:true,completion:nil)
    }
}


