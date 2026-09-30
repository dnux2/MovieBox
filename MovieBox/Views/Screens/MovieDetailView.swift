import SwiftUI

struct MovieDetailView: View {

    // الفيلم اللي جاي من القائمة، عندي منه العنوان والبوستر من الحين
    let movie: Movie
    @State private var viewModel: MovieDetailViewModel
    @Environment(FavoritesStore.self) private var favorites

    init(movie: Movie) {
        self.movie = movie
        _viewModel = State(initialValue: MovieDetailViewModel(movieID: movie.id))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                poster

                details
                    .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favorites.toggle(movie)
                } label: {
                    Image(systemName: favorites.isFavorite(movie) ? "heart.fill" : "heart")
                        .foregroundStyle(favorites.isFavorite(movie) ? .red : .white)
                        .padding(8)
                        .background(.black.opacity(0.35), in: Circle())
                }
            }
        }
        .task {
            if viewModel.detail == nil {
                await viewModel.fetchDetail()
            }
        }
    }

    private var poster: some View {
        Color.clear
            .frame(height: 480)
            .overlay {
                AsyncImage(url: viewModel.detail?.posterURL ?? movie.posterURL) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                    } else {
                        ProgressView()
                    }
                }
            }
            .background(Color(.secondarySystemBackground))
            .clipped()
            .overlay(alignment: .bottomLeading) {
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [.clear, Color(.systemBackground)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200)

                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.primary)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
            }
            .ignoresSafeArea(edges: .top)
    }

    // الأربع حالات للجزء اللي ينجاب من الشبكة
    @ViewBuilder
    private var details: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.top, 20)

        } else if let message = viewModel.errorMessage {
            ErrorView(message: message) {
                Task { await viewModel.fetchDetail() }
            }
            .frame(maxWidth: .infinity)

        } else if let detail = viewModel.detail {
            VStack(alignment: .leading, spacing: 12) {

                HStack(spacing: 8) {
                    Text(detail.releaseYear)
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", detail.voteAverage))
                    if !detail.runtimeText.isEmpty {
                        Text(detail.runtimeText)
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                if !detail.genres.isEmpty {
                    Text(detail.genres.map(\.name).joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text("Overview")
                    .font(.headline)

                if detail.overview.isEmpty {
                    Text("No overview available.")
                        .foregroundStyle(.secondary)
                } else {
                    Text(detail.overview)
                }
            }
        }
    }
}
