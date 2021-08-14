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
    @Published var noNetwork = false
    
    init() {
        loading = true
        checkforStoredData()
    }
    
    private func checkforStoredData() {
        if UserDefaults.standard.object(forKey: "last_stored_date") == nil {
            getMovieList()
        } else {
            /// check to make sure that data has been stored for less then 24 hours before storing more data
            let storedDate = UserDefaults.standard.object(forKey: "last_stored_date") as! Date
            if let diff = Calendar.current.dateComponents([.hour], from: storedDate, to: Date()).hour, diff > 24 {
                /// movies have been stored for more then 24 hours
                if InternetConnectionManager.isConnectedToNetwork(){
                    print("Connected")
                    getMovieList()
                }else{
                    print("Not Connected")
                    noNetwork = true
                }
                getMovieList()
            } else {
                /// movies have been stored for less then 24 hours
                movies.results = getAllMoviesFromStroage()
            }
        }
        
    }
    
    private func getMovieList() {
        print("Retriving Movies from URL")
        guard let url = URL(string: "\(Constants.API_URL)\(Constants.API_KEY)") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let movies = try! JSONDecoder().decode(MovieList.self, from: data)
            self.saveAllMoviesToStorage(movies: movies.results)
            UserDefaults.standard.set(Date(), forKey: "last_stored_date")
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
                    let tempReview = MovieReview(author: reviews.results[i].author, content: reviews.results[i].content, createdAt: reviews.results[i].created_at, id: reviews.results[i].id, updatedAt: reviews.results[i].updated_at)
                    self.movieReviews.append(tempReview)
                }
            }
        }.resume()
    }
    
    func getAllMoviesFromStroage() -> [Movie] {
        print("Retriving Movies from storage")
          if let objects = UserDefaults.standard.value(forKey: "user_objects") as? Data {
             let decoder = JSONDecoder()
             if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Movie] {
                loading = false
                return objectsDecoded
             } else {
                return []
             }
          } else {
             return []
          }
       }
    
    func saveAllMoviesToStorage(movies: [Movie]) {
          let encoder = JSONEncoder()
          if let encoded = try? encoder.encode(movies){
             UserDefaults.standard.set(encoded, forKey: "user_objects")
          }
     }
}
