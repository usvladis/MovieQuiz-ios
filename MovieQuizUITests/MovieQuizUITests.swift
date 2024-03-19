//
//  MovieQuizUITests.swift
//  MovieQuizUITests
//
//  Created by Владислав Усачев on 15.03.2024.
//

import XCTest

 class MovieQuizUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
    }
    
     func testYesButton() {
         sleep(3)
         let firstPoster = app.images["Poster"]
         let firstPosterData = firstPoster.screenshot().pngRepresentation
         app.buttons["Yes"].tap()
         sleep(3)
         let indexLabel = app.staticTexts["Index"]
         let secondPoster = app.images["Poster"]
         let secondPosterData = secondPoster.screenshot().pngRepresentation

         XCTAssertFalse(firstPosterData == secondPosterData)
         XCTAssertEqual(indexLabel.label, "2 / 10")
     }
     
     func testNoButton() {
         sleep(3)
         let firstPoster = app.images["Poster"]
         let firstPosterData = firstPoster.screenshot().pngRepresentation
         app.buttons["No"].tap()
         sleep(3)
         let indexLabel = app.staticTexts["Index"]
         let secondPoster = app.images["Poster"]
         let secondPosterData = secondPoster.screenshot().pngRepresentation

         XCTAssertFalse(firstPosterData == secondPosterData)
         XCTAssertEqual(indexLabel.label, "2 / 10")
     }
     
     func testAlert() {
         sleep(3)
         for i in 1...10 {
             app.buttons["Yes"].tap()
             sleep(3)
         }
         let alert = app.alerts["Игра закончена!"]
         XCTAssertTrue(alert.exists)
         XCTAssertEqual(alert.label, "Игра закончена!")
         XCTAssertEqual(alert.buttons.firstMatch.label, "Сыграть еще раз")
     }
     
     func testAlertButton() {
         sleep(3)
         for i in 1...10 {
             app.buttons["Yes"].tap()
             sleep(3)
         }
         
         app.alerts.buttons.firstMatch.tap()
         sleep(1)
         
         let indexLabel = app.staticTexts["Index"]
         XCTAssertEqual(indexLabel.label, "1 / 10")

     }

}
