//
//  PlayingSongScreen.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import SwiftUI

fileprivate struct PlayingSongHeaderView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
            }.foregroundColor(.white)
            Spacer()
            SPTText(title, style: .headline4)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
            }.foregroundColor(.white)
        }
    }
}

struct PlayingSongScreen: View {
    @EnvironmentObject var viewModel: PlayerViewModel
    var body: some View {
        BlackBGScreen {
            ScrollView(showsIndicators: false) {
                VStack {
                    PlayingSongHeaderView(title: viewModel.currentTrack?.context ?? "Playing song")
                        .padding()
                    switch viewModel.coverImage {
                    case .uiImage(let image):
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 300,
                                   height: 300)
                            .padding()
                    case .url(let urlString):
                        AsyncCachedImage(url: urlString, placeholder: .playlist)
                            .frame(width: 300,
                                   height: 300)
                            .padding()
                    }
                    HStack {
                        TitleSubtitleText(
                            title: viewModel.currentTrack?.name ?? "",
                            subtitle: viewModel.currentTrack?.artistName ?? "",
                            style: .medium
                        )
                        Spacer()
                        Button {} label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.white)
                        }
                    }.padding()
                    
                    PlayerTrackView()
                        .padding(.bottom)
                    
                    PlayingSongControlPanelView()
                        .padding()
                }
            }
        }
    }
}

struct PlayingSongScreen_Preview: PreviewProvider {
    static var previews: some View {
        PlayingSongScreen()
            .environmentObject(PlayerViewModel.filledViewModel())
    }
}
