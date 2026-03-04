import SwiftUI
import SwiftData

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var favourite = false
    
    
    @State private var showAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        
                        if title.isEmpty || author.isEmpty {
                            showAlert = true
                        }

                        else {
                            
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating,)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                        
                    }
                    .alert(isPresented: $showAlert) {
                           Alert(
                               title: Text("Cannot save"),
                               message: Text("Please fill in book and/or author name")
                           )
                    }
                }
                .navigationTitle("Add Book")
                
            }
        }
    }
}
#Preview {
    AddBookView()
}
