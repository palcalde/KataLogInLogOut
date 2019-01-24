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

    init(view: LoginView, timeProvider: TimeProvider = LoginTimeProvider(), validateUserUseCase: ValidateUserUseCase = ValidateUserUseCase()) {
        self.view = view
        self.timeProvider = timeProvider

        self.validateUserUseCase = validateUserUseCase
        self.logOutUserUseCase = LogOutUseCase(timeProvider: timeProvider)
    }

    func didTapOnLogIn(user: String?, pass: String?) {
        let user = user ?? ""
        let pass = pass ?? ""

        validateUserUseCase.validate(user: user, password: pass, completion: { [weak self] result in
            if result {
                self?.view.showLogOut()
            }
        })
    }
    
    func didTapOnLogOut() {
        if logOutUserUseCase.shouldLogOut() {
            view.showLogIn()
        }
    }
}
