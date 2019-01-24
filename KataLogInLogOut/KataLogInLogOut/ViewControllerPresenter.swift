import Foundation

protocol LoginView {
    func showLogIn()
    func showLogOut()
}

class ViewControllerPresenter: ViewControllerActions {
    let validateUserUseCase = ValidateUserUseCase()
    let logOutUserUseCase = LogOutUseCase()

    var view: LoginView!

    init(view: LoginView) {
        self.view = view
    }

    func didTapOnLogIn(user: String?, pass: String?) {
        let user = user ?? ""
        let pass = pass ?? ""

        if validateUserUseCase.validate(user: user, password: pass) {
            view.showLogOut()
        } else {
            fatalError("invalid data")
        }
    }
    
    func didTapOnLogOut() {
        if logOutUserUseCase.shouldLogOut() {
            view.showLogIn()
        }
    }
}
