import SwiftUI
import CoreData

class MainRouter: MainRouterProtocol {

    // MARK: - Properties

    private let persistenceController: PersistenceControllerProtocol

    // MARK: - Init

    init(persistenceController: PersistenceControllerProtocol) {
        self.persistenceController = persistenceController
    }

    // MARK: - Functions

    func navigateToDetail(with note: ToDos) -> AnyView {
        let detailNote = DetailModule(persistenceController: persistenceController)
        return detailNote.createModul(with: note)
    }
}
