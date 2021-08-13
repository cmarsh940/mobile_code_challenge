//
//  MovieDetailView.swift
//  Mobile_Code_Challenge
//
//  Created by Cam on 8/12/21.
//

import SwiftUI

struct MovieDetails : View {
    var movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    
    
    var body: some View {
        VStack(spacing: 10) {
            Image(uiImage: "\(Constants.IMAGE_URL)\(movie.poster_path)".load())
                .resizable()
                .frame(width: UIScreen.main.bounds.height/4, height: UIScreen.main.bounds.height/3)
                .padding()
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Release Date").foregroundColor(.gray)
                    Text(movie.release_date)
                }
                Text("Description").foregroundColor(.gray)
                Text(movie.overview).lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            Text("Reviews")
                .font(.system(size: 32))
                .bold()
            
            List(viewModel.movieReviews) { review in
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 5) {
                        Image(systemName: "person.circle.fill")
                        Text(review.author)
                            .bold()
                    }
                    Text(review.content)
                }
            }
        }
        .onAppear {
            viewModel.getMovieReviews(id: movie.id)
        }
        .navigationBarTitle(Text(movie.title), displayMode: .inline)
            .padding()
    }
}


extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else { return UIImage() }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
        }
        return UIImage()
    }
}
