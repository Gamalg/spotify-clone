//
//  GetUserTopItemsRequest.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 17.05.2023.
//

import Foundation

enum TopItemsTimeRange: String {
    /// approximately last 4 weeks
    case short = "short_term"
    
    /// approximately last 6 months
    case medium = "medium_term"
    
    /// calculated from several years of data and including all new data as it becomes available
    case long = "long_term"
}

struct GetUserTopArtistsRequest: Request {
    typealias ResponseType = TopArtistsResponse
    
    var path: String = "/v1/me/top/artists"
    
    var parameters: [String : Any]
    var headers: [String: String] = [:]
    var method: HTTPMethod = .GET
    var neededAuth: Bool = true
    
    
    init(limit: Int, offset: Int, timeRange: TopItemsTimeRange) {
        parameters = [
            "limit": limit,
            "offset": offset,
            "time_range": timeRange.rawValue
        ]
    }
}
