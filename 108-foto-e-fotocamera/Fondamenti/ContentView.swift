//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var selection: PhotosPickerItem?
    @State private var photo: Data?

    var hasCamera: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Foto del profilo")
                .font(.title)
            if let photo, let picture = UIImage(data: photo) {
                Image(uiImage: picture)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 320)
            }
            PhotosPicker(
                "Scegli una foto",
                selection: $selection,
                matching: .images
            )
            Button("Scatta una foto") {
            }
            .disabled(!hasCamera)
        }
        .padding()
        .task(id: selection) {
            photo = try? await selection?.loadTransferable(
                type: Data.self
            )
        }
    }
}

#Preview {
    ContentView()
}
