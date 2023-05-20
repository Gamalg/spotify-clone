//
//  TrackListView.swift
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
    var body: some View {
        // Author, or created by spotify for ...
        HStack {
            Image(systemName: "music.note.list")
            Text("name")
        }
    }
}

fileprivate struct TrackListItemView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Song name")
                Text("Authors")
            }
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
        }
    }
}

struct TrackListView: View {
    var body: some View {
        // TODO: - Add gradient background
        ScrollView {
            VStack {
                // Image for Track list
                //            Image("")
                AsyncCachedImage(url: "", placeholder: .playlist)
                    .frame(width: 300, height: 300)
                VStack(alignment: .leading) {
                    // Name of list
                    // Album name, mix name, or playlist name
                    Text("List name")
                        .padding(.bottom)
                    
                    AuthorView()
                        .padding(.bottom)
                    ControlPanelView()
                        .padding(.bottom)
                    
                    ForEach(0..<20) { _ in
                        TrackListItemView()
                            .padding(.bottom)
                    }
                }.padding()
            }.safeAreaInset(edge: .bottom, content: {})
        }
    }
}

struct TrackListView_Previews: PreviewProvider {
    static var previews: some View {
        TrackListView()
    }
}
