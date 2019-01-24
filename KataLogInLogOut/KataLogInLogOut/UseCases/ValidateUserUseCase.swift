import Foundation

class ValidateUserUseCase {
    func validate(user: String, password: String) -> Bool {
       return user == "admin" && password == "admin"
    }
}
