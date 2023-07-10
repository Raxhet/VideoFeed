//
//  ContentViewModel.swift
//  VideoFeed
//
//  Created by Илья Меркуленко on 10.07.2023.
//

import Foundation
import SwiftUI
import PhotosUI

class ContentViewModel: ObservableObject {
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet {
            Task {
                try await uploadVideo()
            }
        }
    }
    
    
    func uploadVideo() async throws {
        guard let item = selectedItem else { return }
        guard let data = try await item.loadTransferable(type: Data.self) else { return }
        
        print("Video data is: \(data)")
    }
}
