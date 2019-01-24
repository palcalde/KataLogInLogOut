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

    class ValidateUserUseCaseMock: ValidateUserUseCase {
        var isValid = false

        override func validate(user: String, password: String, completion: @escaping (Bool) -> ()) {
            completion(isValid)
        }
    }

    class LoginViewMock: LoginView {
        var showLogOutCalled = false
        var showLogInCalled = false

        func showLogIn() {
            showLogInCalled = true
        }

        func showLogOut() {
            showLogOutCalled = true
        }
    }

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
        validDataSet.forEach {
            let expectation = self.expectation(description: "Validate user")
            validateUserUseCase.validate(user: $0, password: $1) { result in
                if result {
                    expectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testValidatingFailsForInvalidDataSets() {
        invalidDataSet.forEach {
            let expectation = self.expectation(description: "Validate user")
            validateUserUseCase.validate(user: $0, password: $1) { result in
                if !result {
                    expectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: 10)
    }

    func testLogoutWorksWhenSecondIsEven() {
        timeProviderMock.secondsMocked = 2
        XCTAssertTrue(logOutUseCase.shouldLogOut())
    }

    func testLogoutFailsWhenSecondIsEven() {
        timeProviderMock.secondsMocked = 1
        XCTAssertFalse(logOutUseCase.shouldLogOut())
    }

    func testSuccessfullLogIn() {
        let loginViewMock = LoginViewMock()
        let validateUserMock = ValidateUserUseCaseMock()
        validateUserMock.isValid = true
        
        let presenter = ViewControllerPresenter(view: loginViewMock, validateUserUseCase: validateUserMock)

        presenter.didTapOnLogIn(user: "admin", pass: "admin")

        XCTAssertTrue(loginViewMock.showLogOutCalled)
    }

    func testWrongLogIn() {
        let loginViewMock = LoginViewMock()
        let presenter = ViewControllerPresenter(view: loginViewMock)

        presenter.didTapOnLogIn(user: "", pass: "admin")

        XCTAssertFalse(loginViewMock.showLogInCalled)
    }

    func testSucessfullLogOut() {
        let loginViewMock = LoginViewMock()
        let presenter = ViewControllerPresenter(view: loginViewMock, timeProvider: timeProviderMock)
        timeProviderMock.secondsMocked = 2

        presenter.didTapOnLogOut()

        XCTAssertTrue(loginViewMock.showLogInCalled)
    }

    func testWrongLogOut() {
        let loginViewMock = LoginViewMock()
        timeProviderMock.secondsMocked = 1
        let presenter = ViewControllerPresenter(view: loginViewMock, timeProvider: timeProviderMock)

        presenter.didTapOnLogOut()

        XCTAssertFalse(loginViewMock.showLogOutCalled)
    }
}
