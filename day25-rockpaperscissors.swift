//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jennifer Biggs on 11/26/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @State private var moves = ["👊", "🖐️", "✌️"]
    @State private var outcomes = ["win", "lose"]
    @State private var tryToWin = Int.random(in: 0...1)
    @State private var opponentMove = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questions = 1
    @State private var resetGame = false
    @State private var computerScore = 0
    @State private var playerWins = 0
    
    struct ButtonView: View {
        var move: String

        var body: some View {
            Text(move)
                .font(.largeTitle)
                .frame(width: 90, height: 80)
                .background(.secondary)
                .shadow(color: .gray, radius: 10)
                .cornerRadius(20)
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.9, green: 0.29, blue: 0.5), location: 0.3),
                .init(color: Color(red: 0.05, green: 0.90, blue: 1), location: 1.3)
            ], center: .bottom, startRadius: 100, endRadius: 600)
            .ignoresSafeArea()
            
            VStack {
                Text("Rock Paper Scissors")
                    .font(.title2)
                Text("Speed Challenge")
                    .font(.title2)
                Spacer()
                VStack{
                    Text("Robot selects")
                        .padding()
                        .font(.largeTitle)
                        .foregroundStyle(.primary)
                    VStack {
                        Text(moves[opponentMove])
                        Text("try to")
                            .padding()
                        Text(outcomes[tryToWin])
                            .padding()
                            .foregroundColor(.yellow)
                    }
                    .padding()
                    .font(.largeTitle)
                }
                .frame(maxWidth: 300)
                .padding(.vertical, 10)
                .background(.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            play(move: number)
                        } label: {
                            ButtonView(move: self.moves[number])
                        }
                        
                    } .padding()
                }
                Spacer()
                Spacer()
                VStack {
                    Text("Your score: \(score)")
                        .padding()
                    Text("Robot: \(computerScore)")
                        .padding()
                }
                .font(.largeTitle)
                .frame(maxWidth: 300)
                .padding(.vertical, 10)
                .background(.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questions != 10 {
                Button("Continue", action: nextRound)
            } else {
                Button("Restart", action: gameOver)
            }
        } message: {
                if questions != 10 {
                    Text("Your score: \(score) out of \(questions)")
                } else {
                    Text("You ended the game with score \(score) out of \(questions). Wanna play again?")
                }
            }
        .confettiCannon(counter: $playerWins, num: 30, confettiSize: 20.0)
    }
    
    func play(move: Int) {
    // Rock = 1, Paper = 2, Scissors = 3
    // Try to Win 0 = try to win, 1 = try to lose
        if tryToWin == 0 {
            if (opponentMove == 0 && move == 1) ||
                (opponentMove == 1 && move == 2) ||
                (opponentMove == 2 && move == 0)
            {
                scoreTitle = "Nice, You won!"
                playerWins += 1
                score += 1
            }
            else {
                scoreTitle = "Oops you lost"

                computerScore += 1
            }
        }
        else {
            if (opponentMove == 0 && move == 2) ||
                (opponentMove == 1 && move == 0) ||
                (opponentMove == 2 && move == 1)
            {
                scoreTitle = "You're a great loser"
                playerWins += 1
                score += 1
            }
            else {
                scoreTitle = "Oops you won"

                computerScore += 1
            }
        }
        showingScore = true
    }
    
    func nextRound() {
        tryToWin = Int.random(in: 0...1)
        opponentMove = Int.random(in: 0...2)
        questions += 1
    }
    
    func gameOver() {
        scoreTitle = "Game Over"
        questions = 1
        score = 0
        computerScore = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
