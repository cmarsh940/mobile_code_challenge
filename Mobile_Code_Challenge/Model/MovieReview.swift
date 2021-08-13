//
//  MovieReview.swift
//  Mobile_Code_Challenge
//
//  Created by Cam on 8/13/21.
//

import Foundation


struct MovieReview: Decodable, Identifiable {
    let author: String
    let content: String
    let createdAt: String
    let id: String
    let updatedAt: String
}
