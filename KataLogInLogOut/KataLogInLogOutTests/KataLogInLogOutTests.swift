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

    var validateUserUseCase: ValidateUserUseCase!
    var validDataSet = [("admin", "admin")]
    var invalidDataSet = [("test", "admin"), ("admin", "test"), ("test", "test")]

    override func setUp() {
        validateUserUseCase = ValidateUserUseCase()
    }

    override func tearDown() {
        validateUserUseCase = nil
    }

    func testValidtingWorksCorrectInputs() {
        validDataSet.forEach { XCTAssertTrue(validateUserUseCase.validate(user: $0, password: $1)) }
    }

    func testValidatingFailsForInvalidDataSets() {
        invalidDataSet.forEach { XCTAssertFalse(validateUserUseCase.validate(user: $0, password: $1)) }
    }

}
