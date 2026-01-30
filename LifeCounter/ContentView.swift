//
//  ContentView.swift
//  LifeCounter
//
//  Created by Hanna Pan on 1/29/26.
//

import SwiftUI

struct ContentView: View {
    @State private var player1Life = 20
    @State private var player2Life = 20
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height
            
            VStack(spacing: 16) {
                Group {
                    if (isLandscape) {
                        // horizontal --> side by side player view
                        HStack(spacing: 12) {
                            playerViewPanel(name: "Player 1", life: $player1Life)
                            playerViewPanel(name: "Player 2", life: $player2Life)
                        }
                    } else {
                        // vertical --> top down player view
                        VStack(spacing: 12) {
                            playerViewPanel(name: "Player 1", life: $player1Life)
                            playerViewPanel(name: "Player 2", life: $player2Life)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    Text(winText(player1: player1Life, player2: player2Life))
                    .font(.headline)
                    .padding(.vertical, 20)
                    .padding(.bottom, 40)
                    .foregroundStyle(Color(.red))
                    .frame(maxWidth: geometry.size.width * 0.8, maxHeight: geometry.size.height * 0.3)
                
            }
            .padding(12)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
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
                    }
                    Button("-") {
                        life.wrappedValue -= 1
                    }
                }
                HStack(spacing: 12) {
                    Button("+5") {
                        life.wrappedValue += 5
                    }
                    Button("-5") {
                        life.wrappedValue -= 5
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
    
    
    func winText(player1: Int, player2: Int) -> String {
        if (player1 <= 0) {
            return "Player 1 LOSES!"
        }
        if (player2 <= 0) {
            return "Player 2 LOSES!"
        }
        return ""
    }
    
}

#Preview {
    ContentView()
}
