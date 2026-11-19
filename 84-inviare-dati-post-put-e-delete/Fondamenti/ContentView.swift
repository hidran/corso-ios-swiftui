//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Post: Codable {
    var id: Int?
    var title: String
    var body: String
}

let server = "https://jsonplaceholder.typicode.com/posts"

func makeRequest(_ method: String, _ path: String) -> URLRequest {
    var request = URLRequest(url: URL(string: server + path)!)
    request.httpMethod = method
    let json = "application/json"
    request.setValue(json, forHTTPHeaderField: "Content-Type")
    return request
}

func send(_ request: URLRequest) async throws -> String {
    let session = URLSession.shared
    let (data, response) = try await session.data(for: request)
    let status = (response as? HTTPURLResponse)?.statusCode ?? 0
    let method = request.httpMethod ?? ""
    let reply = try? JSONDecoder().decode(Post.self, from: data)
    if let reply {
        let id = reply.id ?? 0
        return "\(method) \(status), id \(id): \(reply.title)"
    }
    return "\(method) \(status)"
}

struct ContentView: View {
    @State private var log = "Nessuna richiesta"

    var body: some View {
        VStack(spacing: 20) {
            Text(log)
                .font(.headline)
            Button("Crea") {
                Task { await create() }
            }
            Button("Modifica") {
                Task { await update() }
            }
            Button("Elimina") {
                Task { await remove() }
            }
        }
        .buttonStyle(.bordered)
        .padding()
    }

    func create() async {
        var request = makeRequest("POST", "")
        let post = Post(title: "Ciao", body: "Il primo post")
        request.httpBody = try? JSONEncoder().encode(post)
        log = (try? await send(request)) ?? "Errore di rete"
    }

    func update() async {
        var request = makeRequest("PUT", "/1")
        let post = Post(id: 1, title: "Rivisto", body: "Nuovo")
        request.httpBody = try? JSONEncoder().encode(post)
        log = (try? await send(request)) ?? "Errore di rete"
    }

    func remove() async {
        let request = makeRequest("DELETE", "/1")
        log = (try? await send(request)) ?? "Errore di rete"
    }
}

#Preview {
    ContentView()
}
