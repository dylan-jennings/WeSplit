import Foundation
import SwiftData

@Model
class Book {
    
    var favourite: Bool
    var date1: Date
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int

    init(title: String, author: String, genre: String, review: String, rating: Int, favourite: Bool) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.favourite = favourite
        self.date1 = Date.now
    }
}

