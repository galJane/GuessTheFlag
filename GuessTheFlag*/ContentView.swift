//
//  ContentView.swift
//  GuessTheFlag*
//
//  Created by Christian on 2/21/20.
//  Copyright © 2020 Jane. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var status = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        VStack(spacing: 30){
        VStack{
        Text("Tap the flag of")
            .foregroundColor(.white)
        Text(countries[correctAnswer])
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
        }
        ForEach(0..<3){number in
            Button(action: {
                self.flagTapped(number)
            }){
                Image(self.countries[number])
                    .renderingMode(.original)
                .clipShape(Capsule())
          .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
            }
        }
            Text("Current Score: \(score)")
                .foregroundColor(.white)
            Spacer()
    }
    }
         
            .alert(isPresented: $showingScore){
           Alert(title: Text(scoreTitle), message: Text( "\(status)"), dismissButton: .default(Text("Continue")){
               self.askQuestion()
                })
            }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
            status = " That correct! Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            status = "Wrong! That's the flag of \(countries[number]) "
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
