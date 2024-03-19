//
//  MovieQuizTests.swift
//  MovieQuizTests
//
//  Created by Владислав Усачев on 14.03.2024.
//

import XCTest

struct ArithmeticOperations {
    func addition(num1: Int, num2: Int, handler: @escaping(Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            handler(num1 + num2)
        }
    }
    
    func subtraction(num1: Int, num2: Int, handler: @escaping(Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            handler(num1 - num2)
        }
    }
    
    func multiplication(num1: Int, num2: Int, handler: @escaping(Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            handler(num1 * num2)
        }
    }
}

final class MovieQuizTests: XCTestCase {
    
    func testAddition() throws {
        
        //Given
        let num1 = 2
        let num2 = 2
        let arithmeticOperations = ArithmeticOperations()
        
        //When
        let expectation = expectation(description: "Addition function expectation")
        arithmeticOperations.addition(num1: num1, num2: num2) {result in
            
            //Then
            XCTAssertEqual(result, 4)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)
    }

}
