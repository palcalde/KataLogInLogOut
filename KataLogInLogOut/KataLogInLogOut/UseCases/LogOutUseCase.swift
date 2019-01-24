import Foundation

protocol TimeProvider {
    var seconds: Int {get}
}

class LogOutUseCase {
    let timeProvider: TimeProvider

    init(timeProvider: TimeProvider = LoginTimeProvider()) {
        self.timeProvider = timeProvider
    }

    func shouldLogOut() -> Bool {
        return timeProvider.seconds % 2 == 0
    }
}
