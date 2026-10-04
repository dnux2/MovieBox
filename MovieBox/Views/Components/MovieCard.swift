import SwiftUI

struct MovieCard: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            poster

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", movie.voteAverage))
                        .foregroundStyle(.secondary)
                }
                .font(.headline)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
        }
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // المكان ثابت 2:3 سواء نزلت الصورة أو لا، فالبطاقات كلها بنفس الحجم
    private var poster: some View {
        Color(.tertiarySystemBackground)
            .aspectRatio(2/3, contentMode: .fit)
            .overlay {
                if movie.posterURL == nil {
                    // الفيلم ما له بوستر
                    Image(systemName: "film")
                        .font(.title)
                        .foregroundStyle(.secondary)
                } else {
                    AsyncImage(url: movie.posterURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
  //-----------------------------------------------------
                        case .failure(let error):
                            // مؤقت عشان أعرف ليش فشلت، أشيله بعدين
                            let _ = print("Poster failed:", movie.title, error)
                            Image(systemName: "film")
                                .font(.title)
                                .foregroundStyle(.secondary)
//-----------------------------------------------------

                        default:
                            ProgressView()
                        }
                    }
                }
            }
            .clipped()
    }
}
#Preview {
    MovieCard(movie: Movie(
        id: 27205,
        title: "Inception",
        posterPath: "/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg",
        releaseDate: "2010-07-15",
        voteAverage: 8.4,
        overview: "A thief who steals secrets through dreams."
    ))
    .frame(width: 180)
    .padding()
}
