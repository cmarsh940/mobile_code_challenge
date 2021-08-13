//
//  MovieViewModel.swift
//  Mobile_Code_Challenge
//
//  Created by Cam on 8/12/21.
//

import Foundation

public final class MovieViewModel: ObservableObject {
    @Published var movies = MovieList(results: [])
    @Published var reviews = ReviewList(results: [])
    @Published var movieReviews: [MovieReview] = []
    @Published var loading = false
    
    init() {
        loading = true
        getMovieList()
    }
    
    private func getMovieList() {
        guard let url = URL(string: "\(Constants.API_URL)\(Constants.API_KEY)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let movies = try! JSONDecoder().decode(MovieList.self, from: data)
            DispatchQueue.main.async {
                self.movies = movies
                self.loading = false
            }
        }.resume()
    }
    
    func getMovieReviews(id: Int) {
        /// clear any reviews in the movieReview
        self.movieReviews = []
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let reviews = try! JSONDecoder().decode(ReviewList.self, from: data)
            DispatchQueue.main.async {
                /// because of error "Failed to produce diagnostic for expression" when creating a list on MovieDetailView. I could assign the data to the review list but could not access it in a list. so i created a temp review from a basic movieReview and appened the new review into the movieReview array for a quick work around.
                for i in 0..<reviews.results.count {
                    let tempReview = MovieReview(author: reviews.results[i].author, content: reviews.results[i].content, createdAt: reviews.results[i].createdAt, id: reviews.results[i].id, updatedAt: reviews.results[i].updatedAt)
                    self.movieReviews.append(tempReview)
                }
            }
        }.resume()
    }
}
