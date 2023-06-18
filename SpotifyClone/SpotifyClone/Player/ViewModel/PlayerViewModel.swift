//
//  PlayerViewModel.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 28.05.2023.
//

import Foundation
import SpotifyiOS

class PlayerViewModel: NSObject, ObservableObject, SPTAppRemotePlayerStateDelegate, SPTAppRemoteDelegate {
    struct PlaybackState {
        var isShuffled: Bool = false
        var repeatMode: RepeatMode = .off
    }
    
    enum CoverImage {
        case url(String)
        case uiImage(UIImage)
    }
    
    @Published var currentTrack: AppTrack?
    @Published var playbackState: PlaybackState = PlaybackState()
    @Published var currentValue = 0.0
    @Published var isPlaying: Bool = false
    @Published var coverImage: PlayerViewModel.CoverImage = .uiImage(UIImage())
    
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
    
    // MARK: - Connection
    
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

        appRemote.playerAPI?.play(uri, asRadio: false, callback: { _, _ in })
    }

    func playContainer(item: SPTAppRemoteContentItem, index: Int = 0) {
        if !appRemote.isConnected {
            appRemote.authorizeAndPlayURI(item.identifier)
            return
        }
        
        appRemote.playerAPI?.play(item, skipToTrackIndex: index)
    }
    
    func playTrackListItem(_ trackListItem: TrackListItem) {
        playURI(trackListItem.spotifyURI)
    }
    
    // MARK: - Player Control
    
    func skipForward() {
        appRemote.playerAPI?.skip(toNext: { _, _ in
        })
    }
    
    func skipBackward() {
        appRemote.playerAPI?.skip(toPrevious: { _, _ in
        })
    }
    
    func seekForward15Seconds() {
        appRemote.playerAPI?.seekForward15Seconds()
    }
    
    func seekBackward15Seconds() {
        appRemote.playerAPI?.seekBackward15Seconds()
    }
    
    func skipToPosition(_ seconds: Double) {
        timer.invalidate()
        let mili = Int(seconds) * 1000
        appRemote.playerAPI?.seek(toPosition: mili)
    }
    
    func resume() {
        appRemote.playerAPI?.resume()
    }
    
    func pause() {
        appRemote.playerAPI?.pause()
    }
    
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        self.currentTrack = AppTrack(playerState: playerState)
        
        self.currentValue = Double(playerState.playbackPosition.toSeconds())
        self.isPlaying = !playerState.isPaused
        
        updatePlayerPlaybackState(playerState.playbackOptions)
        
        if self.isPlaying {
            timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
        }
        
        appRemote.imageAPI?.fetchImage(forItem: playerState.track, with: .init(width: 1000, height: 1000)) { [weak self] result, _ in
            guard let image = result as? UIImage else { return }
            self?.coverImage = .uiImage(image)
        }
    }
    
    private func updatePlayerPlaybackState(_ state: SPTAppRemotePlaybackOptions) {
        let state = PlaybackState(isShuffled: state.isShuffling, repeatMode: state.repeatMode.toRepeatMode())
        self.playbackState = state
    }
    
    // MARK: - Playback state
    
    func toggleShuffled() {
        let shuffled = playbackState.isShuffled
        appRemote.playerAPI?.setShuffle(!shuffled) { [weak self] result, _ in
            guard let self = self, let _ = result else { return }
            self.playbackState.isShuffled = !shuffled
        }
    }
    
    func changeRepeatMode() {
        let nextMode = playbackState.repeatMode.next()
        appRemote.playerAPI?.setRepeatMode(nextMode.toSPTAppRemotePlaybackOptionsRepeatMode()) { [weak self] result, _ in
            guard let self = self, let _ = result else { return }
            self.playbackState.repeatMode = nextMode
        }
    }
    
    @objc private func fireTimer() {
        currentValue += 1
    }
    
    // MARK: - SPTAppRemoteDelegate
    
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
        return viewModel
    }
}
