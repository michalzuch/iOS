//
//  HUDNotification.swift
//  OAuth
//
//  Created by Michał Zuch on 04/02/2024.
//

import SwiftUI

struct HUDNotification: View {
    let text: String
    let image: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 200, height: 200)
                .foregroundStyle(.black.opacity(0.6))
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 200, height: 200)
                .foregroundStyle(.ultraThinMaterial)
            
            VStack {
                Text(text)
                    .font(.title2)
                    .foregroundStyle(.regularMaterial)
                    .padding()
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(30)
                    .foregroundStyle(.regularMaterial)
            }
            .frame(width: 200, height: 200)
            .cornerRadius(25)
            .padding()
        }
    }
}

#Preview {
    HUDNotification(text: "Signed Up", image: "person.fill.checkmark")
}
