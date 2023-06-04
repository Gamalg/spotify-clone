//
//  TrackListContainerView.swift
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
            }.padding(.trailing)
            Button(action: {}) {
                Image(systemName: "arrow.down.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.trailing)
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            Spacer()
            Button(action: {}) {
                Image(systemName: "shuffle")
                    .resizable()
                    .frame(width: 25, height: 20)
            }
            .padding(.trailing)
            Button(action: {}) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 44, height: 44)
            }
        }
    }
}

fileprivate struct AuthorView: View {
    let imageURL: String
    let authorName: String
    var body: some View {
        // Author, or created by spotify for ...
        HStack {
            AsyncCachedImage(url: imageURL, placeholder: .playlist)
            Text(authorName)
                .font(SPTTextStyle.body.font.weight(.bold))
                .foregroundColor(.white)
        }
    }
}

struct TrackListContainerData {
    let name: String
    let creator: String
    let trackListItems: [TrackListItem]
    let imageURL: String
}

struct TrackListContainerView: View {
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
                        //            Image("")
                        AsyncCachedImage(url: viewModel.imageURL, placeholder: .playlist)
                            .frame(width: 300, height: 300)
                        VStack(alignment: .leading) {
                            // Name of list
                            // Album name, mix name, or playlist name
                            Text(containerData.name)
                                .font(SPTTextStyle.headline1.font)
                                .foregroundColor(.white)
                                .padding(.bottom)
                            
                            AuthorView(imageURL: containerData.imageURL,
                                       authorName: containerData.creator)
                                .padding(.bottom)
                            ControlPanelView()
                                .padding(.bottom)
                            
                            ForEach(containerData.trackListItems) { trackListItem in
                                TrackListItemView(trackListItem: trackListItem)
                                    .padding(.bottom)
                                    .onTapGesture {
                                        playerViewModel.playTrackListItem(trackListItem)
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
        TrackListContainerView(viewModel: .init(imageURL: "", type: .playlist("")))
    }
}
