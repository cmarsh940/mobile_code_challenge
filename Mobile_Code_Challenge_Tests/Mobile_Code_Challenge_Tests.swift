//
//  Mobile_Code_Challenge_Tests.swift
//  Mobile_Code_Challenge_Tests
//
//  Created by Cam on 8/13/21.
//

@testable import Mobile_Code_Challenge
import XCTest

class Mobile_Code_Challenge_Tests: XCTestCase {

    func test_parsing_movie_data() throws {
        let json = """
            {
                "page": 1,
                "results": [
                    {
                        "adult": false,
                        "backdrop_path": "/rAgsOIhqRS6tUthmHoqnqh9PIAE.jpg",
                        "genre_ids": [
                            28,
                            12,
                            14
                        ],
                        "id": 436969,
                        "original_language": "en",
                        "original_title": "The Suicide Squad",
                        "overview": "Supervillains Harley Quinn, Bloodsport, Peacemaker and a collection of nutty cons at Belle Reve prison join the super-secret, super-shady Task Force X as they are dropped off at the remote, enemy-infused island of Corto Maltese.",
                        "popularity": 10896.338,
                        "poster_path": "/kb4s0ML0iVZlG6wAKbbs9NAm6X.jpg",
                        "release_date": "2021-07-28",
                        "title": "The Suicide Squad",
                        "video": false,
                        "vote_average": 8.1,
                        "vote_count": 1809
                    },
                    {
                        "adult": false,
                        "backdrop_path": "/rUoGZuscSG4fQP3I56ndadu2A8E.jpg",
                        "genre_ids": [
                            28,
                            35
                        ],
                        "id": 729720,
                        "original_language": "fr",
                        "original_title": "Le Dernier Mercenaire",
                        "overview": "A mysterious former secret service agent must urgently return to France when his estranged son  is falsely accused of arms and drug trafficking by the government, following a blunder by an overzealous bureaucrat and a mafia operation.",
                        "popularity": 3213.38,
                        "poster_path": "/ttpKJ7XQxDZV252KNEHXtykYT41.jpg",
                        "release_date": "2021-07-30",
                        "title": "The Last Mercenary",
                        "video": false,
                        "vote_average": 6.7,
                        "vote_count": 162
                    },
                ],
                "total_pages": 500,
                "total_results": 10000
            }
        """
        
        let jsonData = json.data(using: .utf8)!
        let movieData = try! JSONDecoder().decode(MovieList.self, from: jsonData)
        
        XCTAssertEqual(436969, movieData.results[0].id)
        XCTAssertEqual("The Last Mercenary", movieData.results[1].title)
    }
    
    func test_can_parse_movie_json_file() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "testData", ofType: "json") else {
            fatalError("json not found")
        }
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert json to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let movieData = try! JSONDecoder().decode(MovieList.self, from: jsonData)
        
        XCTAssertEqual(436969, movieData.results[0].id)
        
    }

}
