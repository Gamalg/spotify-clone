//
//  PlayingSongScreen.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import SwiftUI

fileprivate struct PlayingSongHeaderView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
            }.foregroundColor(.white)
            Spacer()
            SPTText("Playing song", style: .headline4)
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
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack {
                        PlayingSongHeaderView()
                            .padding()
                        AsyncCachedImage(url: "", placeholder: .playlist)
                            .frame(width: geometry.size.width - 32,
                                   height: geometry.size.width - 32)
                            .padding()
                        HStack {
                            VStack(alignment: .leading) {
                                SPTText(
                                    viewModel.state?.songName ?? "",
                                    style: .headline3
                                )
                                SPTText(
                                    viewModel.state?.artistName ?? "",
                                    style: .body,
                                    foregroundColor: .lightGray
                                )
                            }
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
}

struct PlayingSongScreen_Preview: PreviewProvider {
    static var previews: some View {
        PlayingSongScreen()
            .environmentObject(PlayerViewModel.filledViewModel())
    }
}
