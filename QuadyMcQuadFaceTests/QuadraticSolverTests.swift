//
//  QuadraticSolverTests.swift
//  QuadyMcQuadFaceTests
//
//  Created by Robert Huston on 2/27/22.
//

import XCTest
@testable import QuadyMcQuadFace

class QuadraticSolverTests: XCTestCase {

    func testFindsDistinctRealRoots() throws {
        let result = QuadraticSolver(a: 3.0, b: -9.0, c: 6.0)
        
        XCTAssertEqual(result.x1 as? Double, 1.0)
        XCTAssertEqual(result.x2 as? Double, 2.0)
    }

    func testFindsRepeatedRealRoots() throws {
        let result = QuadraticSolver(a: 2.0, b: -28.0, c: 98.0)
        
        XCTAssertEqual(result.x1 as? Double, 7.0)
        XCTAssertEqual(result.x2 as? Double, 7.0)
    }

    func testFindsPlusMinusRealRoots() throws {
        let result = QuadraticSolver(a: 1.0, b: 0.0, c: -1.0)
        
        XCTAssertEqual(result.x1 as? Double, -1.0)
        XCTAssertEqual(result.x2 as? Double, 1.0)
    }

    func testFindsComplexRoots() throws {
        let result = QuadraticSolver(a: 1.0, b: 1.0, c: 1.0)
        
        let sqrt3_div_2 = sqrt(3.0) / 2.0
        XCTAssertEqual(result.x1 as? Complex, Complex(real: -0.5, imag: -sqrt3_div_2))
        XCTAssertEqual(result.x2 as? Complex, Complex(real: -0.5, imag: sqrt3_div_2))
    }

    func testFindsImaginaryRoots() throws {
        let result = QuadraticSolver(a: 1.0, b: 0.0, c: 1.0)
        
        XCTAssertEqual(result.x1 as? Complex, Complex(real: 0.0, imag: -1.0))
        XCTAssertEqual(result.x2 as? Complex, Complex(real: 0.0, imag: 1.0))
    }

}
