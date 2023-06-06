//
//  ArtistService.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 04.06.2023.
//

import Foundation

/// List of keywords that will be used to filter the response
enum ArtistAlbumIncludeGroups: String {
    case album
    case single
    case appearsOn = "appears_on"
    case compilation
}

protocol ArtistServiceProtocol {
    func getArtist(id: SpotifyID) async throws -> Artist
    
    /// Get Spotify catalog information for several artists based on their Spotify IDs.
    /// - Parameter ids: A comma-separated list of the Spotify IDs for the artists. Maximum: 50 IDs.
    func getSeveralArtists(ids: [SpotifyID]) async throws -> [Artist]
    
    func getArtistAlbum(id: SpotifyID, includeGroups: String)
}
