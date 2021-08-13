//
//  Movie.swift
//  Mobile_Code_Challenge
//
//  Created by Cam on 8/12/21.
//

import Foundation

struct Movie: Decodable, Identifiable {
    let popularity: Float
    let vote_count: Int
    let id: Int
    let vote_average: Float
    let title: String
    let poster_path: String
    let original_language: String
    let original_title: String
    let adult: Bool
    let overview: String
    let release_date: String
}
