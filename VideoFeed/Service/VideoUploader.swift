//
//  VideoUploader.swift
//  VideoFeed
//
//  Created by Илья Меркуленко on 11.07.2023.
//

import Foundation
import FirebaseStorage

struct VideoUploader {
    
    static func uploadVideo(videoData: Data) async throws -> String? {
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference().child("/videos/\(fileName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "video/quicktime"
        
        // TODO: Monitoring uploading progress
        
//        let uploadTask = ref.putData(videoData, metadata: metadata)
//        uploadTask.observe(.progress) { snap in
//            guard let progress = snap.progress else { return }
//            let comp = 100.0 * Double(progress.completedUnitCount) / Double(progress.totalUnitCount)
//
//            DispatchQueue.main.async {
//                //status = String(format: "Uploading %.1f%%", comp)
//            }
//        }
        
        do {
            let _ = try await ref.putDataAsync(videoData, metadata: metadata)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("Failed to upload video with error \(error.localizedDescription)")
            return nil
        }
    }
}
