//
//  PlayingSongPreviewView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import SwiftUI

struct PlayingSongPreviewView: View {
    @EnvironmentObject var viewModel: PlayerViewModel
    @State private var showingSheet = false
    var body: some View {
        if viewModel.currentTrack == nil {
            HStack {}
        } else {
            content
        }
    }
     
    private var content: some View {
        HStack {
            switch viewModel.coverImage {
            case .url(let url):
                AsyncCachedImage(url: url, placeholder: .playlist)
                    .frame(width: 36, height: 36)
                    .padding(.leading)
            case .uiImage(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.leading)
            }
            TitleSubtitleText(
                title: viewModel.currentTrack?.name ?? "",
                subtitle: viewModel.currentTrack?.artistName ?? "",
                style: .small
            ).padding()
            Spacer()
            PlayButton(style: .borderless)
                .frame(width: 22, height: 22)
                .padding(.trailing)
        }
        .background(Color.spBlack)
        .fullScreenCover(isPresented: $showingSheet) {
            PlayingSongScreen()
        }
        .onTapGesture {
            showingSheet.toggle()
        }
    }
}

struct PlayerPreviewView_Preview: PreviewProvider {
    static var previews: some View {
        PlayingSongPreviewView()
            .environmentObject(PlayerViewModel.filledViewModel())
    }
}
