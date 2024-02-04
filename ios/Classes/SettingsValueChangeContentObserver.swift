
// import Flutter
// import UIKit

// public class SettingsValueChangeContentObserver: NSObject, UIApplicationDelegate {

//     private var eventStateSink: EventConnectStateStreamHandler?

//     func register(Context applicationContext) {
//         NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChanged), name: NSNotification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)

//         updateSettings();
//     }
//     func registerEvent(event:EventConnectStateStreamHandler) {
//         if (eventStateSink == null) {
//             eventStateSink = event;
//         }
//     }
//     func updateSettings(){
//       let orientation = UIDevice.current.orientation
//       if orientation.isPortrait {
//           print("isPortrait")
//       }else if orientation.isLandscape {
//           print("isLandscape")
//       } else {
//           print("isPortrait")
//       }
//     }
    
//     @objc func deviceOrientationChanged() {
//         print("Orientation changed")
//         inspectDeviceOrientation()
//     }

//     func inspectDeviceOrientation() {
//         let orientation = UIDevice.current.orientation
        
//        // if orientation == previousDeviceOrientation { return }
//         previousDeviceOrientation = orientation
//         print("deviceDidRotate")
    
// //        switch UIDevice.current.orientation {
// //        case .portrait:
// //            print("portrait")
// //        case .landscapeLeft:
// //            print("landscapeLeft")
// //        case .landscapeRight:
// //            print("landscapeRight")
// //        case .portraitUpsideDown:
// //            print("portraitUpsideDown")
// //        case .faceUp:
// //            print("faceUp")
// //        case .faceDown:
// //            print("faceDown")
// //        default: // .unknown
// //            print("unknown")
// //        }
//         if orientation.isPortrait {
//             print("isPortrait")
//         }else if orientation.isLandscape {
//             print("isLandscape")
//         } else {
//             print("isPortrait")
//         }
//     }
// // switch UIDevice.current.userInterfaceIdiom {
// // case .phone:
// //     // iPhone、iPod touch

// // case .pad:
// //     // iPad

// // case .tv:
// //     // Apple TV

// // case .carPlay:
// //     // CarPlay

// // case .unspecified:
// // }
// //     func test(){
// //         let app = UIApplication.shared
// //         let statusBar: Any? = nil
// //         //    判断是否是iOS 13
// //         let network = ""
// //         let changedColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
// // //        let statusBar1 = UIView()
// //         if #available(iOS 13.0, *) {
// // //            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
// // //                            statusBar.backgroundColor = changedColor
// // //                           UIApplication.shared.keyWindow?.addSubview(statusBar)
// //             let statusBarManager = UIApplication.shared.keyWindow?.windowScene?.statusBarManager
// // //            print(statusBarManager?.statusBarFrame.origin.dictionaryRepresentation)
// //             print(statusBarManager?.accessibilityFrame)
// //             //print(statusBarManager?.autoContentAccessingProxy)
// //             //print(statusBarManager?.)
// //             let statusBarManagerx = UIApplication.shared.keyWindow?.windowScene?.interfaceOrientation
// //             print(statusBarManagerx?.rawValue)
// //             let statusBarManagerx1 = UIApplication.shared.keyWindow?.windowScene?.title
// //             print(statusBarManagerx1)
            
// //             let  keyWindow = UIApplication.shared.connectedScenes
// //             for windowScene in UIApplication.shared.connectedScenes {
// //                 guard let windowScene = windowScene as? UIWindowScene else {
// //                     continue
// //                 }
// //                 if windowScene.activationState == .foregroundActive {
// //                     var isOn = false
// //                     var cls: UIView.Type?
// //                     cls = NSClassFromString("_UIStatusBarImageView") as? UIView.Type
// //                     for window in windowScene.windows {
// //                         for subviews in window.subviews {
// //                             print(subviews.frame.size)
// //                     if let cls1 = cls, subviews.isKind(of: cls1), subviews.frame.size.equalTo(CGSize(width: 11.5, height: 10.0)) {
// //                                     isOn = true
// //                                     break
// //                                 }
// //                         }
// //                     }
// //                     print(isOn)
// // //                    for window in windowScene.windows {
// // //                        for subviews in window.subviews {
// // //                            subviews.isKind(of: <#T##AnyClass#>)
// // //                            print(subviews.frame.size)
// // //                        }
// // //                       // if window.isKeyWindow {
// // //
// // //                       // }
// // //                    }
// //                     break
// //                 }
// //             }
// // //            self.statusBar1.frame = (UIApplication.shared.currentScene?.statusBarManager!.statusBarFrame)!

// // //            print(statusBarManager?.accessibilityFrame)
// // //            //#pragma clang diagnostic push
// // //            //#pragma clang diagnostic ignored "-Wundeclared-selector"
// // //            if statusBarManager?.responds(to: Selector("createLocalStatusBar")) ?? false {
// // //                let localStatusBar = statusBarManager?.perform(Selector("createLocalStatusBar")) as? UIView
// //                 //if localStatusBar.responds(to:#selector(setter: UIView.)) {

// // //                if localStatusBar?.responds(to: #selector(NSStatusItem.statusBar)) ?? false {
// // //                    statusBar = localStatusBar?.perform(#selector(NSStatusItem.statusBar))
// //                 //}
// // //            }
// //             //#pragma clang diagnostic pop
// //         }
// //     }
// }
