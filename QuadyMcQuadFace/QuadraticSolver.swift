//
//  QuadraticSolver.swift
//  QuadyMcQuadFace
//
//  Created by Robert Huston on 2/27/22.
//

import Foundation

func QuadraticSolver(a: Double, b: Double, c: Double) -> (x1: Any, x2: Any) {
    var result: (x1: Any, x2: Any)
    
    // Po-Shen Loh method
    let xm = -b / (2 * a)
    let discr = xm * xm - c / a
    if (discr < 0) {
        let d = sqrt(-discr)
        result = (x1: Complex(real: xm, imag: -d), x2: Complex(real: xm, imag: d))
    } else {
        let d = sqrt(discr)
        result = (x1: xm - d, x2: xm + d)
    }
    
    return result
}
