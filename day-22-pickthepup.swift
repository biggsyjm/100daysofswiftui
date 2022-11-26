//
//  ContentView.swift
//  GuessTheDog
//
//  Created by Jennifer Biggs on 11/25/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questions = 0
    @State private var resetGame = false
    @State private var counter = 0
    
    @State private var countries = ["Affenpinscher", "Akita", "Australian Cattle Dog", "Beagle", "Bichon Frise", "Boxer", "Bulldog", "Dachshund", "German Shepherd", "Labrador Retriever", "Maltese", "Papillon", "Pug", "Samoyed", "Shiba Inu", "Weimaraner"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...1)
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.6, blue: 0.55), location: 0.3),
                .init(color: Color(red: 0.6, green: 0.25, blue: 0.66), location: 0.3)
            ], center: .bottom, startRadius: 200, endRadius: 300)
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Pick the Pup")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the image of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
 
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<2) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }

                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Text("out of \(questions)")
                    .foregroundColor(.white)
                    .font(.callout.bold())
                
                Spacer()
        }
            .padding()
    }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questions != 5 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: gameOver)
            }
        } message: {
                if questions != 5 {
                    Text("Your score is \(score) out of \(questions)")
                } else {
                    Text("You ended the game with score \(score) out of \(questions). Wanna play again?")
                }
            }
        .confettiCannon(counter: $counter, num: 30, confettis: [.text("🐶")], confettiSize: 30.0)
        

        
    }
    func flagTapped(_ number: Int) {

        if number == correctAnswer {
            scoreTitle = "You got it!"
            score += 1
            counter += 1
            if questions == 5 {
                resetGame = true
                showingScore = false
            }
        } else {
            scoreTitle = "Wrong! That's the image of \(countries[number])"
        }
        questions += 1
        showingScore = true

    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...1)
    }
    
    func gameOver() {
        askQuestion()
        questions = 1
        score = 0

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
