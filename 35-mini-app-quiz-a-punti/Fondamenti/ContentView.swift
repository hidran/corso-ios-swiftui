//
//  ContentView.swift
//  Fondamenti
//
//  Created by the studio on 11/11/26.
//

import SwiftUI

struct Question {
    let text: String
    let answers: [String]
    let correct: Int

    static let samples = [
        Question(text: "Quale pizza è piccante?",
                 answers: ["Margherita", "Diavola", "Marinara"],
                 correct: 1),
        Question(text: "Dove è nata la pizza?",
                 answers: ["Milano", "Roma", "Napoli"],
                 correct: 2)
    ]
}

enum Feedback {
    case waiting
    case right
    case wrong

    var message: String {
        switch self {
        case .waiting:
            return "Scegli una risposta"
        case .right:
            return "Giusto! Più 10 punti"
        case .wrong:
            return "Sbagliato"
        }
    }
}

struct Quiz {
    let questions: [Question]
    var index = 0
    var score = 0
    var feedback = Feedback.waiting

    var current: Question {
        return questions[index]
    }

    mutating func answer(_ choice: Int) {
        guard feedback == .waiting else {
            return
        }
        if choice == current.correct {
            score += 10
            feedback = .right
        } else {
            feedback = .wrong
        }
    }

    mutating func next() {
        index = (index + 1) % questions.count
        feedback = .waiting
    }
}

struct ContentView: View {
    @State private var quiz = Quiz(questions: Question.samples)

    var body: some View {
        VStack(spacing: 16) {
            Text("Punti: \(quiz.score)")
                .font(.headline)
            Text(quiz.current.text)
                .font(.title2)
                .bold()
            Button(quiz.current.answers[0]) { quiz.answer(0) }
            Button(quiz.current.answers[1]) { quiz.answer(1) }
            Button(quiz.current.answers[2]) { quiz.answer(2) }
            Text(quiz.feedback.message)
            Button("Avanti") { quiz.next() }
        }
        .buttonStyle(.bordered)
        .padding()
    }
}

#Preview {
    ContentView()
}
