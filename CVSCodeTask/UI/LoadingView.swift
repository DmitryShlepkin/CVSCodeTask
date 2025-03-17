//
//  LoadingView.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .offset(x: 0, y: -15)
                .accessibilityLabel("Loading")
                .padding(.bottom, 16)
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color(.systemGray5), lineWidth: 4)
                .frame(width: 150, height: 4)
                .offset(x: 0, y: 15)
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color(.systemGray), lineWidth: 4)
                .frame(width: 30, height: 4)
                .offset(x: isLoading ? 60 : -60, y: 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.myPrimaryInverted).opacity(0.8))
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isLoading = true
            }
        }
    }
    
}

#Preview {
    LoadingView()
}
