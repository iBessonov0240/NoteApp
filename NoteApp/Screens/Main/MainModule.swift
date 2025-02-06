import SwiftUI

final class MainModule {

    // MARK: - Properties

    private let persistenceController: PersistenceControllerProtocol

    // MARK: - Init

    init(persistenceController: PersistenceControllerProtocol) {
        self.persistenceController = persistenceController
    }

    // MARK: - Functions

    func createModul() -> AnyView {
        let interactor = MainInteractor(persistenceController: persistenceController)
        let router = MainRouter(persistenceController: persistenceController)
        let presenter = MainPresenter(interactor: interactor, router: router)
        return AnyView(Main(presenter: presenter))
    }
}
