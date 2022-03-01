//
//  Complex.swift
//  QuadyMcQuadFace
//
//  Created by Robert Huston on 2/27/22.
//

import Foundation

struct Complex {
    var real: Double
    var imag: Double
}

extension Complex: Equatable {
    static func == (lhs: Complex, rhs: Complex) -> Bool {
        return lhs.real == rhs.real && lhs.imag == rhs.imag
    }
}
