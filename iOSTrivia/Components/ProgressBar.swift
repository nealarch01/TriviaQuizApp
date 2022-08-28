//
//  ProgressBar.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import SwiftUI

struct ProgressBar: View {
    let percentComplete: Double
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    GeometryReader { innerGeometry in
                        RoundedRectangle(cornerRadius: 12) // This frame will be updated
                            .fill(Color.yellow)
                            .frame(width: innerGeometry.size.width * percentComplete)
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.clear)
                    }
                }
                .frame(width: geometry.size.width * 0.85) // Takes up 85% of the screen
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray)
                }
                .frame(width: geometry.size.width) // Centers the view
            }
        }
        .frame(height: 10)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(percentComplete: 0.5)
    }
}
