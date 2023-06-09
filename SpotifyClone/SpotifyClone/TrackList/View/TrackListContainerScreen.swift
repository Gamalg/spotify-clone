//
//  TrackListContainerScreen.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 20.05.2023.
//

import SwiftUI

fileprivate struct ControlPanelView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.lightGray)
            }.padding(.trailing)
            Button(action: {}) {
                Image(systemName: "arrow.down.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.lightGray)
            }.padding(.trailing)
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.lightGray)
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .foregroundColor(.lightGray)
            }
            .padding(.trailing)
            Button(action: {}) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.spGreen)
            }
        }
    }
}

fileprivate struct AuthorView: View {
    let imageURL: String?
    let authorName: String
    var body: some View {
        // Author, or created by spotify for ...
        HStack {
            if let url = imageURL {
                AsyncCachedImage(url: url, placeholder: .playlist)
                    .frame(width: 25, height: 25)
            }
            SPTText(authorName, style: .headline4)
            Spacer()
        }
    }
}

struct TrackListContainerScreen: View {
    @ObservedObject var viewModel: TrackListContainerViewModel
    @EnvironmentObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        // TODO: - Add gradient background
        BlackBGScreen {        
            ScrollView(showsIndicators: false) {
                VStack {
                    switch viewModel.state {
                    case .loading:
                        ProgressView()
                    case .loaded(let containerData):
                        // Image for Track list
                        AsyncCachedImage(url: viewModel.imageURL, placeholder: .playlist)
                            .frame(width: 300, height: 300)
                        VStack(alignment: .leading) {
                            // Name of list
                            // Album name, mix name, or playlist name
                            SPTText(containerData.name, style: .headline1)
                                .padding(.bottom)
                            
                            AuthorView(imageURL: containerData.creatorImage,
                                       authorName: containerData.creator)
                                .padding(.bottom)
                            ControlPanelView()
                                .padding(.bottom)
                            
                            ForEach(containerData.tracks) { track in
                                let item = TrackListItem(track: track)
                                TrackListItemView(trackListItem: item)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        // track number in disc starts from 1
                                        playerViewModel.playContainer(item: track, index: track.index - 1)
                                    }
                            }
                        }.padding()
                    }
                }.onAppear(perform: viewModel.loadTracks)
            }
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListContainerScreen(viewModel: .init(imageURL: "", type: .playlist("")))
    }
}
