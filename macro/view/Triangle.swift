//
//  Triangle.swift
//  macro
//
//  Created by Nouf on 06/05/2025.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))     // top
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))  // bottom right
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))  // bottom left
        path.closeSubpath()
        return path
    }
}


#Preview {
    Triangle()
}
