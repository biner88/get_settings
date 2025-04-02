#if os(iOS)
import Flutter
import UIKit
#elseif os(macOS)
import FlutterMacOS
import Cocoa
import AppKit
#endif
import WebKit
public class GetSettingsPlugin: NSObject, FlutterPlugin {
    private var channel:FlutterMethodChannel?
    private let eventListener: EventStateStreamHandler = EventStateStreamHandler()
    private var eventState: FlutterEventChannel?
    #if os(iOS)
    private var previousDeviceOrientation: UIDeviceOrientation = UIDevice.current.orientation
    #endif
    init(with registrar: FlutterPluginRegistrar) {}
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = GetSettingsPlugin(with: registrar)
        #if os(iOS)
          let messenger = registrar.messenger()
        #else
          let messenger = registrar.messenger
        #endif
        instance.channel = FlutterMethodChannel(name: "get_settings", binaryMessenger: messenger)
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: instance.channel!)
        //
        instance.eventState = FlutterEventChannel(name: "get_settings_channel", binaryMessenger: messenger)
        instance.eventState?.setStreamHandler(instance.eventListener)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? NSDictionary
        switch call.method {
        case "isRotationOn":
            #if os(iOS)
            NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
            result(true)
            #else
            result(false)
            #endif
            break
        case "getPlatformVersion":
           #if os(iOS)
           result(UIDevice.current.systemVersion)
           #elseif os(macOS)
           let version = ProcessInfo.processInfo.operatingSystemVersion
           result("\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)")
           #endif
            break
        case "isiOSAppOnMac":
            result(false)
            break;
        case "getUserAgent":
            getUserAgent { userAgent in
                            result(userAgent)
                        }
            break
        case "getCPUType":
            result(getCPUType())
            break
        case "isPad":
            #if os(iOS)
           result(UIDevice.current.userInterfaceIdiom == .pad)
           #else
           result(false)
           #endif
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
                    let targetUriResult = targetUri ?? ""
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
        result(FlutterMethodNotImplemented)
        } 
    }
#if os(iOS)
    @objc func deviceOrientationChanged() {
        print("Orientation changed")
        inspectDeviceOrientation()
    }

    func inspectDeviceOrientation() {
        let orientation = UIDevice.current.orientation
        previousDeviceOrientation = orientation
    }
    func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
#endif
    func getUserAgent(completion: @escaping (String) -> Void) {
        #if os(iOS)
        let versionArray = UIDevice.current.systemVersion.split(separator: ".")
        let agentCPUVersion = versionArray.joined(separator: "_")
        let agentVersion = versionArray[0] + "_" + versionArray[1]
        var deviceType = "iPhone"
        if UIDevice.current.userInterfaceIdiom == .pad {
            deviceType = "iPad"
        }
        completion("Mozilla/5.0 (\(deviceType); CPU \(deviceType) OS \(agentCPUVersion) like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/\(agentVersion) Mobile/15E148 Safari/604.1")
        #elseif os(macOS)
        let webView = WKWebView()
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let userAgent = result as? String {
                completion(userAgent)
            } else {
                completion("Mozilla/5.0 (Macintosh; Intel Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Safari")
            }
        }
        #endif
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
        
       #if os(iOS)
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
       #endif
    }
}
