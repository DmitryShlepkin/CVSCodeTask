//
//  MessageView.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct MessageView: View {
    
    let title: String
    let description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(.body, design: .rounded))
                .accessibilityLabel(title)
            Text(description)
                .font(.system(.body, design: .rounded))
                .foregroundColor(Color.gray)
                .accessibilityLabel(description)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.myPrimaryInverted).opacity(0.8))
        .padding(.horizontal, 16)
    }
    
}

#Preview {
    MessageView(
        title: "Title",
        description: "Description"
    )
}
