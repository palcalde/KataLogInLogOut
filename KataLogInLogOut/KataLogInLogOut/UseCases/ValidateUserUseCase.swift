import Foundation

class ValidateUserUseCase {
    func validate(user: String, password: String, completion: @escaping (_ result: Bool) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(user == "admin" && password == "admin")
        }
    }
}
