//
//  Restrictions.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 03.06.2023.
//

import Foundation

/// Included in the response when a content restriction is applied.
struct Restrictions: Hashable, Decodable {
    /**
     The reason for the restriction. Supported values:

     market - The content item is not available in the given market.
     product - The content item is not available for the user's subscription type.
     explicit - The content item is explicit and the user's account is set to not play explicit content.
     Additional reasons may be added in the future. Note: If you use this field, make sure that your application safely handles unknown values.
     */
    let reason: String
}
