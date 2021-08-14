//
//  Review.swift
//  Mobile_Code_Challenge
//
//  Created by Cam on 8/12/21.
//

import Foundation

struct Review: Codable {
    let id, page: Int?
    let results: [Result]?
    let total_pages, total_results: Int?
}

struct Result: Codable {
    let author: String
    let content, created_at, id, updated_at: String
    let url: String
}
