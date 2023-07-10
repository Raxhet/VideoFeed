//
//  ContentView.swift
//  VideoFeed
//
//  Created by Илья Меркуленко on 10.07.2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(0...5, id: \.self) { video in
                    Text("Video placeholder")
                }
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
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
