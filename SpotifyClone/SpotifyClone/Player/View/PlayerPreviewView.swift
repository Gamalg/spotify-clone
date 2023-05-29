//
//  PlayingSongPreviewView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import SwiftUI

struct PlayingSongPreviewView: View {
    @EnvironmentObject var viewModel: PlayerViewModel
    var body: some View {
        if viewModel.state == nil {
            HStack {}
        } else {
            content
                .frame(height: 56)
        }
    }
     
    private var content: some View {
        HStack {
            Image("")
                .resizable()
                .background(Color.red)
                .frame(width: 25, height: 25)
                .padding(.leading)
            VStack(alignment: .leading) {
                Text(viewModel.state?.songName ?? "")
                Text(viewModel.state?.artistName ?? "")
            }.padding(.leading)
            Spacer()
            Button(action: {}) {
                Image(systemName: "play.fill")
            }.padding(.trailing)
        }.background(Color.gray)
    }
}

struct PlayerPreviewView_Preview: PreviewProvider {
    static var previews: some View {
        PlayingSongPreviewView()
            .environmentObject(PlayerViewModel.filledViewModel())
    }
}
