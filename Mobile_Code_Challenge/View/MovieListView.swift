//
//  MovieListView.swift
//  Mobile_Code_Challenge
//
//  Created by Cam on 8/12/21.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel = MovieViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                    Text("Loading ...")
                } else {
                    List(viewModel.movies.results) { movie in
                        NavigationLink(destination: MovieDetails(movie: movie, viewModel: viewModel)){
                            MovieRow(movie: movie)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Movies"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
