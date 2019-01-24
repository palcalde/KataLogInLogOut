import Foundation

protocol LoginView {
    func showLogIn()
    func showLogOut()
}

class ViewControllerPresenter: ViewControllerActions {
    let validateUserUseCase: ValidateUserUseCase
    let logOutUserUseCase: LogOutUseCase

    var view: LoginView!
    var timeProvider: TimeProvider

    init(view: LoginView, timeProvider: TimeProvider = LoginTimeProvider()) {
        self.view = view
        self.timeProvider = timeProvider

        self.validateUserUseCase = ValidateUserUseCase()
        self.logOutUserUseCase = LogOutUseCase(timeProvider: timeProvider)
    }

    func didTapOnLogIn(user: String?, pass: String?) {
        let user = user ?? ""
        let pass = pass ?? ""

        if validateUserUseCase.validate(user: user, password: pass) {
            view.showLogOut()
        }
    }
    
    func didTapOnLogOut() {
        if logOutUserUseCase.shouldLogOut() {
            view.showLogIn()
        }
    }
}
