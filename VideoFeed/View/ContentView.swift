//
//  ContentView.swift
//  VideoFeed
//
//  Created by Илья Меркуленко on 10.07.2023.
//

import SwiftUI
import PhotosUI
import AVKit

struct ContentView: View {
    
    @StateObject var vm = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.videos) { video in
                    VideoPlayer(player: AVPlayer(url: URL(string: video.videoUrl)!))
                        .frame(height: 240)
                }
            }
            .refreshable {
                Task { vm.fetchVideos }
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    PhotosPicker(selection: $vm.selectedItem, matching: .videos) {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
