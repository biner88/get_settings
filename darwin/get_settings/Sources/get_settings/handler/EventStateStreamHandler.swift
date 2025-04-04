#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#endif
class EventStateStreamHandler: NSObject,FlutterStreamHandler {
    private var eventSink: FlutterEventSink?
    
    public func send(res:Bool){
        if let event = eventSink {
            event(res)
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
