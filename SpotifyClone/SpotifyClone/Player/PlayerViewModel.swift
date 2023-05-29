//
//  PlayerViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import Foundation
import SpotifyiOS

class PlayerViewModel: NSObject, ObservableObject, SPTAppRemotePlayerStateDelegate, SPTAppRemoteDelegate {
    struct State {
        let artistName: String
        let songName: String
        let duration: Double
    }
    
    @Published var state: PlayerViewModel.State?
    @Published var currentValue = 0.0
    @Published var isPlaying: Bool = false
    
    private let configuration = SPTConfiguration(clientID: GlobalConstants.spotifyClientID, redirectURL: URL(string: GlobalConstants.redirectURI)!)
    private let appRemote: SPTAppRemote
    private var timer = Timer()
    
    override init() {
        appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(disconnect), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(connect), name: UIApplication.willEnterForegroundNotification, object: nil)
        appRemote.playerAPI?.delegate = self
        appRemote.delegate = self
    }
    
    var isConnected: Bool {
        appRemote.isConnected
    }
    
    @objc
    func connect() {
        let token = AppDIContainer.shared.authManager.token.value?.accessToken
        appRemote.connectionParameters.accessToken = token
        appRemote.connect()
        appRemote.playerAPI?.delegate = self
    }
    
    @objc
    private func disconnect() {
        appRemote.disconnect()
    }
    
    func playURI(_ uri: String) {
        if !appRemote.isConnected {
            appRemote.authorizeAndPlayURI(uri)
            return
        }

        appRemote.playerAPI?.play(uri, asRadio: false, callback: { [weak self] isSuccess, _ in
            guard let self = self else { return }
            if isSuccess != nil {
//                self.isPlaying = true
//                self.timer.invalidate()
//                self.currentValue = 0
//                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
            }
        })
    }
    
    @objc private func fireTimer() {
        currentValue += 1
    }
    
    func playTrackListItem(_ trackListItem: TrackListItem) {
        state = PlayerViewModel.State(trackListItem)
        playURI(trackListItem.spotifyURI)
    }
    
    func skipToPosition(_ seconds: Double) {
        let mili = Int(seconds) * 1000
        appRemote.playerAPI?.seek(toPosition: mili)
    }
    
    func resume() {
        appRemote.playerAPI?.resume { [weak self] isSuccess, _ in
            guard let self = self else { return }
            if isSuccess != nil {
//                self.isPlaying = true
//                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    func pause() {
        appRemote.playerAPI?.pause { [weak self] isSuccess, _ in
            guard let self = self else { return }
            if isSuccess != nil {
//                self.isPlaying = false
//                timer.invalidate()
            }
        }
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        self.state = State(
            artistName: playerState.track.artist.name,
            songName: playerState.track.name,
            duration: Double(playerState.track.duration / 1000))
        self.currentValue = Double(playerState.playbackPosition / 1000)
        self.isPlaying = !playerState.isPaused
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        
    }
    
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        appRemote.playerAPI?.delegate = self
        appRemote.playerAPI?.subscribe()
    }
    
    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
    }
}

extension PlayerViewModel {
    static func filledViewModel() -> PlayerViewModel {
        let viewModel = PlayerViewModel()
        viewModel.state = State(artistName: "Linkin Park", songName: "Numb", duration: 325)
        return viewModel
    }
}

extension PlayerViewModel.State {
    init(_ trackListItem: TrackListItem) {
        self.artistName = trackListItem.authorName
        self.songName = trackListItem.name
        self.duration = trackListItem.durationInSeconds
    }
}
