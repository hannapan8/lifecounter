//
//  ContentView.swift
//  LifeCounter
//
//  Created by Hanna Pan on 1/29/26.
//

import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var life: Int
}

struct ContentView: View {
//    @State private var player1Life = 20
//    @State private var player2Life = 20
    @State private var players: [Player] = [
        Player(name: "Player 1", life: 20),
        Player(name: "Player 2", life: 20),
        Player(name: "Player 3", life: 20),
        Player(name: "Player 4", life: 20)
    ]
    @State private var startGame = false
    @State private var lifeText = "5"
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            let numRows = isLandscape ? 4 : 2
            
            VStack(spacing: 16) {
                HStack {
                    Button("Add player") {
                        let newPlayerCount = players.count + 1
                        players.append(Player(name: "Player \(newPlayerCount)", life: 20))
                    }
                    .disabled(startGame || players.count >= 8)
                }
                
                HStack (spacing: 12) {
                    Text("Change life by:")
                        .font(.headline)
                    
                    TextField("Amount", text: $lifeText)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 90)
                    

                }
                .padding(.horizontal, 4)
                
                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(0..<players.count, id: \.self) { i in
                            if (i % 2 == 0) {
                                HStack(spacing: 12) {
                                    if (i + 1 < players.count) {
                                        playerViewPanel(name: players[i].name, life: $players[i].life)
                                        
                                        playerViewPanel(name: players[i + 1].name, life: $players[i + 1].life)
                                    } else {
                                        HStack {
                                            Spacer()
                                            playerViewPanel(name: players[i].name, life: $players[i].life)
                                                .frame(maxWidth: 300)
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
                .padding(20)
                .background(Color(.systemBackground))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .layoutPriority(1)
                
//                Group {
//                    if (isLandscape) {
//                        // horizontal --> side by side player view
//                        HStack(spacing: 12) {
//                            ForEach(0..<players.count, id: \.self) { i in
//                                playerViewPanel(name: players[i].name, life: $players[i].life)
//                            }
//                            
//                            // playerViewPanel(name: "Player 1", life: $player1Life)
//                            // playerViewPanel(name: "Player 2", life: $player2Life)
//                        }
//                    } else {
//                        // vertical --> top down player view
//                        VStack(spacing: 12) {
//                            ForEach(0..<players.count, id: \.self) { i in
//                                playerViewPanel(name: players[i].name, life: $players[i].life)
//                            }
//                            
//                            // playerViewPanel(name: "Player 1", life: $player1Life)
//                            // playerViewPanel(name: "Player 2", life: $player2Life)
//                        }
//                    }
//                }

                Text(winText())
                    .font(.headline)
//                    .padding(.vertical, 12)
//                    .padding(.bottom, 12)
                    .foregroundStyle(Color(.red))

                
            }
            .padding(12)
        }
    }
    
    func playerViewPanel(name: String, life: Binding<Int>) -> some View {
        VStack(spacing: 12) {
            Text(name)
                .font(.title2)
                .fontWeight(.bold)
        
            Text("\(life.wrappedValue)")
                .font(.system(size: 30, weight: .semibold))
                
            // buttons
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    Button("+") {
                        life.wrappedValue += 1
                        startGame = true
                    }
                    Button("-") {
                        life.wrappedValue -= 1
                        startGame = true
                    }
                }
                HStack(spacing: 12) {
                    Button("+\(lifeChangeValue())") {
                        let amount = lifeChangeValue()
                        if (amount > 0) {
                            life.wrappedValue += amount
                            startGame = true
                        }
                    }
                    Button("-\(lifeChangeValue())") {
                        let amount = lifeChangeValue()
                        if (amount > 0) {
                            life.wrappedValue -= amount
                            startGame = true
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(alignment: .center)
        .padding(18)
        .background(Color(.systemBackground))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator), lineWidth: 1)
        )
    }
    
    
    func winText() -> String {
        for i in 0..<players.count {
            if (players[i].life <= 0) {
                return "\(players[i].name) LOSES!"
            }
        }
        return ""
    }
    
    func lifeChangeValue() -> Int {
        let num = Int(lifeText) ?? 0
        // limit the number ppl can enter
        return max(0, min(999, num))
    }
    
}

#Preview {
    ContentView()
}
