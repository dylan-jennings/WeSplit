
import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false

    let book: Book

    var body: some View {
        ScrollView {
            
            Text(book.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }

            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
                .padding()

            Text(book.review)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            Spacer()
            Spacer()
            
            Text("Reviewed: \(Date.now, format: .dateTime.day().month().year())")
                .foregroundStyle(.secondary)
            
        }
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }

    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}
