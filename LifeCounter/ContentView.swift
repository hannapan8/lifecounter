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
    @State private var history: [String] = []
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let isLandscape = geometry.size.width > geometry.size.height
                let numRow = isLandscape ? 4 : 2
                
                VStack(spacing: 16) {
                    HStack {
                        Button("Add Player") {
                            let newPlayerCount = players.count + 1
                            players.append(Player(name: "Player \(newPlayerCount)", life: 20))
                        }
                        .disabled(startGame || players.count >= 8)
                        
                        Button("Remove Player") {
                            players.removeLast()
                        }
                        .disabled(startGame || players.count <= 2)
                        
                        NavigationLink("History") {
                            ViewHistory(history: history)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
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
                                if (i % numRow == 0) {
                                    HStack(spacing: 0) {
                                        playerViewPanel(name: players[i].name, life: $players[i].life)
                                            .frame(maxWidth: 300)

                                        if (i + 1 < players.count && numRow >= 2) {
                                            playerViewPanel(name: players[i + 1].name, life: $players[i + 1].life)
                                                .frame(maxWidth: 300)
                                        }

                                        // horizontal view
                                        if (numRow == 4){
                                            if (i + 2 < players.count) {
                                                playerViewPanel(name: players[i + 2].name, life: $players[i + 2].life)
                                                    .frame(maxWidth: 300)
                                            }
                                            
                                            if (i + 3 < players.count) {
                                                playerViewPanel(name: players[i + 3].name, life: $players[i + 3].life)
                                                    .frame(maxWidth: 300)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .padding(20)
                    .layoutPriority(1)
                    .background(Color(.systemBackground))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    Text(winText())
                        .font(.headline)
                        .foregroundStyle(Color(.red))

                    
                }
                .padding(12)
            }
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
                        history.append("\(name) gained 1 life.")
                    }
                    Button("-") {
                        life.wrappedValue -= 1
                        startGame = true
                        history.append("\(name) lost 1 life.")
                    }
                }
                HStack(spacing: 12) {
                    Button("+\(lifeChangeValue())") {
                        let amount = lifeChangeValue()
                        if (amount > 0) {
                            life.wrappedValue += amount
                            startGame = true
                            history.append("\(name) gained \(amount) life.")
                        }
                    }
                    Button("-\(lifeChangeValue())") {
                        let amount = lifeChangeValue()
                        if (amount > 0) {
                            life.wrappedValue -= amount
                            startGame = true
                            history.append("\(name) lost \(amount) life.")
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
        return num
    }
    
}

#Preview {
    ContentView()
}
