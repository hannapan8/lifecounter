//
//  ViewHistory.swift
//  LifeCounter
//
//  Created by Hanna Pan on 2/3/26.
//

import SwiftUI

struct ViewHistory: View {
    let history: [String]
    
    var body: some View {
        Text("Game History")
            .font(.title2)
            .fontWeight(.bold)
        
        List {
            if (!history.isEmpty) {
                ForEach(0..<history.count, id: \.self) { i in
                    Text(history[i])
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("No history yet. Game has not started.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

