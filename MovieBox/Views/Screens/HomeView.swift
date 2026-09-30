import SwiftUI

struct HomeView: View {

    @State private var viewModel = HomeViewModel()

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                header
                content
            }
            .background { AppBackground() }
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Movie.self) { movie in
                MovieDetailView(movie: movie)
            }
        }
        .task {
            // ما أحمّل من جديد لو عندي أفلام
            if viewModel.movies.isEmpty {
                await viewModel.fetchMovies()
            }
        }
    }

    private var header: some View {
        HStack {
            Text("MovieBox")
                .font(.title2)
                .bold()
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 15)
    }

    // كل حالة لها شكل مختلف
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.movies.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if let message = viewModel.errorMessage, viewModel.movies.isEmpty {
            ErrorView(message: message) {
                Task { await viewModel.fetchMovies() }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if viewModel.movies.isEmpty {
            EmptyStateView(message: "No movies found.")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.movies) { movie in
                        NavigationLink(value: movie) {
                            MovieCard(movie: movie)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
            .refreshable {
                await viewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(FavoritesStore())
}
