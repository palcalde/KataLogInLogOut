//
//  KataLogInLogOutTests.swift
//  KataLogInLogOutTests
//
//  Created by Pablo A on 24/01/2019.
//  Copyright © 2019 Cabify. All rights reserved.
//

import XCTest
@testable import KataLogInLogOut

class KataLogInLogOutTests: XCTestCase {

    class TimeProviderMock: TimeProvider {
        var secondsMocked: Int?

        var seconds: Int {
            if let seconds = secondsMocked {
                return seconds
            } else {
                return 0
            }
        }
    }

    var timeProviderMock = TimeProviderMock()
    var logOutUseCase: LogOutUseCase!
    var validateUserUseCase: ValidateUserUseCase!
    var validDataSet = [("admin", "admin")]
    var invalidDataSet = [("test", "admin"), ("admin", "test"), ("test", "test")]

    override func setUp() {
        logOutUseCase = LogOutUseCase(timeProvider: timeProviderMock)
        validateUserUseCase = ValidateUserUseCase()
    }

    override func tearDown() {
        logOutUseCase = nil
        validateUserUseCase = nil
    }

    func testValidtingWorksCorrectInputs() {
        validDataSet.forEach { XCTAssertTrue(validateUserUseCase.validate(user: $0, password: $1)) }
    }

    func testValidatingFailsForInvalidDataSets() {
        invalidDataSet.forEach { XCTAssertFalse(validateUserUseCase.validate(user: $0, password: $1)) }
    }

    func testLogoutWorksWhenSecondIsEven() {
        timeProviderMock.secondsMocked = 2
        XCTAssertTrue(logOutUseCase.shouldLogOut())
    }

    func testLogoutFailsWhenSecondIsEven() {
        timeProviderMock.secondsMocked = 1
        XCTAssertFalse(logOutUseCase.shouldLogOut())
    }

}
