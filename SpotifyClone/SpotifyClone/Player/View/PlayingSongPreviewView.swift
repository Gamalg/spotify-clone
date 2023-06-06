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
        if viewModel.state == nil {
            HStack {}
        } else {
            content
        }
    }
     
    private var content: some View {
        HStack {
            Image("")
                .resizable()
                .background(Color.red)
                .frame(width: 36, height: 36)
                .padding(.leading)
            VStack(alignment: .leading) {
                Text(viewModel.state?.songName ?? "")
                Text(viewModel.state?.artistName ?? "")
            }.padding()
            Spacer()
            Button(action: {
                viewModel.isPlaying ? viewModel.pause() : viewModel.resume()
            }) {
                let image = viewModel.isPlaying ? Image(systemName: "pause.fill") : Image(systemName: "play.fill")
                image
                    .resizable()
                    .frame(width: 22, height: 22)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 24))
        }
        .background(Color.gray)
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
