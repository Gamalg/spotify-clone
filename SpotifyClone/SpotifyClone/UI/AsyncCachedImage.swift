//
//  ImageByURLView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 30.04.2023.
//

import SwiftUI

class AsyncCachedImageViewModel: ObservableObject {
    @Published var image: Image?
    let url: String
    private let imageLoader = ImageLoadClient()
    
    init(url: String) {
        self.url = url
    }
    
    func getImage() {
        Task {
            do {
                guard let url = URL(string: url) else { throw ImageLoadClientError.noImage }
                let uiImage = try await imageLoader.getImage(for: url)
                
                await MainActor.run {
                    self.image = Image(uiImage: uiImage)
                        .resizable()
                }
            }
        }
    }
}

struct AsyncCachedImage: View {
    @ObservedObject private var viewModel: AsyncCachedImageViewModel
    private let placeholder: ImagePlaceholder
    
    init(url: String, placeholder: ImagePlaceholder) {
        self.viewModel = AsyncCachedImageViewModel(url: url)
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                image
            } else {
                placeholder.backgroundColor
                placeholderView()
            }
        }.onAppear(perform: viewModel.getImage)
    }
    
    private func placeholderView() -> some View {
        switch placeholder.type {
        case .custom(let name):
            return Image(name)
                .foregroundColor(placeholder.tintColor)
        case .system(let name):
            return Image(systemName: name)
                .renderingMode(.template)
                .foregroundColor(placeholder.tintColor)
        }
    }
}

struct ImageByURLView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncCachedImage(url: "", placeholder: .playlist)
    }
}
