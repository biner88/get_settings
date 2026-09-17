import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import AVFoundation
import AVKit
public class IpodToPath {

    func export(_ assetURL: URL, _ rewrite: Bool) -> String? {
        guard assetURL.scheme == "ipod-library" else {
            return nil
        }

        let components = URLComponents(url: assetURL, resolvingAgainstBaseURL: false)
        let ipodId = components?.queryItems?
            .first(where: { $0.name == "id" })?.value ?? ""
        if ipodId.isEmpty { return nil }

        let cacheDir = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first!
        let dir = cacheDir.appendingPathComponent("music_cache")
        try? FileManager.default.createDirectory(
            at: dir,
            withIntermediateDirectories: true
        )

        let outputURL = dir.appendingPathComponent("\(ipodId).m4a")

        if FileManager.default.fileExists(atPath: outputURL.path) {
            if rewrite {
                do {
                    try FileManager.default.removeItem(at: outputURL)
                } catch {
                    return nil
                }
            } else {
                return outputURL.path
            }
        }

        let asset = AVURLAsset(url: assetURL)

        guard let exporter = AVAssetExportSession(
            asset: asset,
            presetName: AVAssetExportPresetAppleM4A
        ) else {
            return nil
        }

        exporter.outputURL = outputURL
        exporter.outputFileType = .m4a
        exporter.shouldOptimizeForNetworkUse = true

        let exportSemaphore = DispatchSemaphore(value: 0)
        exporter.exportAsynchronously {
            exportSemaphore.signal()
        }
        _ = exportSemaphore.wait(timeout: .distantFuture)

        if exporter.status == .completed {
            return outputURL.path
        } else {
            print("Export failed:", exporter.error?.localizedDescription ?? "")
            return nil
        }
    }
}
