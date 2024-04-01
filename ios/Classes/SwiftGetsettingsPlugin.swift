import Flutter
import UIKit
import SwiftUI

public class SwiftGetsettingsPlugin: NSObject, FlutterPlugin {
    private var channel:FlutterMethodChannel?
    private let eventListener: EventStateStreamHandler = EventStateStreamHandler()
    private var eventState: FlutterEventChannel?
    private var previousDeviceOrientation: UIDeviceOrientation = UIDevice.current.orientation

    init(with registrar: FlutterPluginRegistrar) { }
    //   private  var mSettingsObserver:SettingsValueChangeContentObserver = SettingsValueChangeContentObserver()


    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftGetsettingsPlugin(with: registrar)
            instance.channel = FlutterMethodChannel(name: "GetsettingsPlugin", binaryMessenger: registrar.messenger())
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
        //
        instance.eventState = FlutterEventChannel(name: "GetSettingsChannel", binaryMessenger: registrar.messenger())
        instance.eventState?.setStreamHandler(instance.eventListener)
    }

    @objc func deviceOrientationChanged() {
        print("Orientation changed")
        inspectDeviceOrientation()
    }

    func inspectDeviceOrientation() {
        let orientation = UIDevice.current.orientation
        previousDeviceOrientation = orientation
        if orientation.isPortrait {
            print("isPortrait")
        }else if orientation.isLandscape {
            print("isLandscape")
        } else {
            print("isPortrait")
        }
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String : Any?]
        switch call.method {
        case "isRotationOn":
            //let device = UIDevice.current
            // UIDevice.current.beginGeneratingDeviceOrientationNotifications()
          //   var notificationCenter = NotificationCenter.default
//             NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChanged),
//                 name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
//                 object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChanged), name: NSNotification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)

            print("isRotationOn!")
            break
        case "getPlatformVersion":
            result(UIDevice.current.systemVersion)
            break
        case "isiOSAppOnMac":
            var isMac = false
            if #available(iOS 14.0, *) {
                isMac = ProcessInfo.processInfo.isiOSAppOnMac
            }
            result(isMac)
            break;
        case "getUserAgent":
            result(getUserAgent())
            break
        case "getCPUType":
            result(getCPUType())
            break
        case "isPad":
            result(isPad())
            break
        case "ipodToPath":
            let ipodLibraryUri = args!["ipodLibraryUri"] as! String
            let assetURL = URL.init(string: ipodLibraryUri)!
            let rewrite = args!["rewrite"] as! Bool
            let ipodToPath = IpodToPath()
            //
            DispatchQueue.global().async {
                do {
                    let targetUri =  ipodToPath.export(assetURL,rewrite)
                    var targetUriResult = targetUri ?? ""
                    DispatchQueue.main.async {
                        result(targetUriResult)
                    }
                }
            }
            break
        case "contentToPath":
            result("")
            break
        default:
            result("unkown")
        }
    }
    func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    func getUserAgent() -> String {
        let versionArray = UIDevice.current.systemVersion.split(separator: ".")
        let agentCPUVersion =  versionArray.joined(separator: "_")
        let agentVersion = versionArray[0] + "_" + versionArray[1]
        var deviceType = "iPhone"
        if UIDevice.current.userInterfaceIdiom == .phone {
            deviceType = "iPhone"
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            deviceType = "iPad"
        }
        return "Mozilla/5.0 (\(deviceType); CPU \(deviceType) OS \(agentCPUVersion) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(agentVersion) Mobile/15E148 Safari/604.1"
    }
    func getCPUType() -> String? {
        var type: String?
        var size = MemoryLayout<cpu_type_t>.size
        var cpuType = cpu_type_t(0)
        let result = sysctlbyname("hw.cputype", &cpuType, &size, nil, 0)
        if result == 0 {
            switch cpuType {
            case CPU_TYPE_ARM:
                type = "ARM"
            case CPU_TYPE_ARM64:
                type = "ARM64"
            case CPU_TYPE_X86:
                type = "X86"
            case CPU_TYPE_X86_64:
                type = "X86_64"
            default:
                type = nil
            }
        }
        return type
    }
    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        channel?.setMethodCallHandler(nil)
        eventState?.setStreamHandler(nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
    }

}
