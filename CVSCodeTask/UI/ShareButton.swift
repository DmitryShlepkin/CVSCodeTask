//
//  ShareButton.swift
//  CVSCodeTask
//
//  Created by Dmitry Shlepkin on 3/14/25.
//

import SwiftUI

struct ShareButton: View {
    
    let link: String?
    let title: String
    let message: String
    let accessbilityLabel: String = "Share"
    
    var body: some View {
        ShareLink(
            item: link ?? "",
            subject: Text(title),
            message: Text(message)
        )
        .disabled(link == nil)
        .accessibilityLabel(accessbilityLabel)
    }
    
}

