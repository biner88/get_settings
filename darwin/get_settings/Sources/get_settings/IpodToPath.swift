import Foundation
#if os(iOS)
import UIKit
import AssetsLibrary
#elseif os(macOS)
import AppKit
#endif
import AVFoundation
import AVKit

public class IpodToPath {
    func export(_ assetURL: URL,_ rewrite: Bool) -> String?{
        guard assetURL.scheme == "ipod-library" else {
            return nil
        }
        var ipodId = ""
        if let value = URLComponents(url: assetURL, resolvingAgainstBaseURL: false)?.queryItems?.first(where: { $0.name == "id" })?.value {
            ipodId = value
        }
        if(ipodId == ""){return nil}
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent("\(ipodId).m4a")
        if FileManager.default.fileExists(atPath: outputURL.path) {
            if(rewrite){
                do {
                    try FileManager.default.removeItem(at: outputURL)
                } catch {
                    return nil
                }
            }else{
                return outputURL.path
            }
        }
        //
        let asset = AVURLAsset(url: assetURL)
        
//        let audioFile = try! AVAudioFile(forReading: assetURL)
//        print("audioFile:\(audioFile.url)")
        
        guard let exporter = AVAssetExportSession(
            asset: asset,
            presetName: AVAssetExportPresetAppleM4A
        ) else {
            return nil
        }
        exporter.outputURL = outputURL
        exporter.outputFileType = AVFileType.m4a
        //
        let exportSemaphore = DispatchSemaphore(value: 0)
        exporter.exportAsynchronously {
            exportSemaphore.signal()
        }
        _ = exportSemaphore.wait(timeout: .distantFuture)
    
        if exporter.status == .completed {
            return outputURL.path
        } else {
            return nil
        }
    }
}
