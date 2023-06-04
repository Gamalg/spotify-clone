//
//  SpotifyID.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

/**
 The base-62 identifier found at the end of the Spotify URI (see above) for an artist, track, album, playlist, etc.
 Unlike a Spotify URI, a Spotify ID does not clearly identify the type of resource; that information is provided elsewhere in the call.

 Example: 6rqhFgbbKwnb9MLmUQDhG6
 */
typealias SpotifyID = String

/**
 The resource identifier of, for example, an artist, album or track.
 This can be entered in the search box in a Spotify Desktop Client, to navigate to that resource.
 To find a Spotify URI, right-click (on Windows) or Ctrl-Click (on a Mac) on the artist, album or track name.

 Example: spotify:track:6rqhFgbbKwnb9MLmUQDhG6
 */
typealias SpotifyURI = String

/**
 The unique string identifying the Spotify user that you can find at the end of the Spotify URI for the user.
 The ID of the current user can be obtained via the Get Current User's Profile endpoint.

 Example: wizzler
 */
typealias SpotifyUserID = String

/// A link to the Web API endpoint
typealias WebAPIEndpointLink = String
