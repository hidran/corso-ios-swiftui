//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Book: Identifiable {
    let id = UUID()
    var title: String
    var author: String
    var color: Color = .indigo
    var isRead = false
}

extension Book {
    static let samples = [
        Book(title: "I promessi sposi",
             author: "Alessandro Manzoni", color: .orange),
        Book(title: "Il fu Mattia Pascal",
             author: "Luigi Pirandello", color: .teal),
        Book(title: "Orgoglio e pregiudizio",
             author: "Jane Austen", color: .pink, isRead: true),
        Book(title: "Moby Dick",
             author: "Herman Melville", color: .red, isRead: true)
    ]
}

struct ContentView: View {
    @State private var books = Book.samples

    var body: some View {
        NavigationStack {
            List(books) { book in
                NavigationLink(value: book.id) {
                    BookRow(book: book)
                }
            }
            .navigationTitle("Libreria")
            .navigationDestination(for: UUID.self) { id in
                let index = books.firstIndex { $0.id == id }
                if let index {
                    BookDetail(book: books[index])
                }
            }
        }
    }
}

struct BookRow: View {
    let book: Book

    var body: some View {
        HStack(spacing: 12) {
            BookCover(color: book.color)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if book.isRead {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
            }
        }
    }
}

struct BookCover: View {
    let color: Color
    var height: CGFloat = 60

    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(color.gradient)
            .frame(width: height * 0.7, height: height)
            .overlay {
                Image(systemName: "book.closed.fill")
                    .font(.system(size: height * 0.35))
                    .foregroundStyle(.white)
            }
    }
}

struct BookDetail: View {
    let book: Book

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                BookCover(color: book.color, height: 240)
                Text(book.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                Text(book.author)
                    .font(.title3)
                    .foregroundStyle(.secondary)
                if book.isRead {
                    Label("Letto", systemImage: "checkmark")
                } else {
                    Label("Da leggere", systemImage: "book")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
