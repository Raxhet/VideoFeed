//
//  ContentViewModel.swift
//  VideoFeed
//
//  Created by Илья Меркуленко on 10.07.2023.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestoreSwift

class ContentViewModel: ObservableObject {
    @Published var videos = [Video]()
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await uploadVideo()
            }
        }
    }
    
    init() {
        Task {
            try await fetchVideos()
        }
    }
    
    func uploadVideo() async throws {
        guard let item = selectedItem else { return }
        guard let data = try await item.loadTransferable(type: Data.self) else { return }
        
        print("Video data is: \(data)")
        
        guard let videoUrl = try await VideoUploader.uploadVideo(videoData: data) else { return }
        
        try await Firestore.firestore().collection("videos").document().setData(["videoUrl": videoUrl])
        
        print("Finished video upload...")
    }
    
    @MainActor
    func fetchVideos() async throws {
        let snap = try await Firestore.firestore().collection("videos").getDocuments()
        self.videos = snap.documents.compactMap({ try? $0.data(as: Video.self) })
    }
}
