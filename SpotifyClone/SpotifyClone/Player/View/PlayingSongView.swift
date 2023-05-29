//
//  PlayingSongView.swift
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
            }
            Spacer()
            Text("Playing song")
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
            }
        }
    }
}

fileprivate struct PlayingSongControlPanelView: View {
    @EnvironmentObject var viewModel: PlayerViewModel
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 26, height: 22)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "backward.end.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
            }.padding(.trailing)
            Spacer()
            Button(action: {
                viewModel.isPlaying ? viewModel.pause() : viewModel.resume()
            }) {
                // play.circle.fill
                Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
            }.padding(.trailing)
            Spacer()
            Button(action: {}) {
                Image(systemName: "forward.end.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "arrow.rectanglepath")
                    .resizable()
                    .frame(width: 26, height: 22)
            }
        }
    }
}

struct PlayingSongView: View {
    @EnvironmentObject var viewModel: PlayerViewModel
    var body: some View {
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
                        VStack {
                            Text("Song name")
                            Text("Artist Name")
                        }
                        Spacer()
                        Button {} label: {
                            Image(systemName: "plus.circle")
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

struct PlayingSongView_Preview: PreviewProvider {
    static var previews: some View {
        PlayingSongView()
    }
}
