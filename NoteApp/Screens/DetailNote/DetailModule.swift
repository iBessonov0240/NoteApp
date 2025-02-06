import SwiftUI

final class DetailModule {

    // MARK: - Properties

    private let persistenceController: PersistenceControllerProtocol

    // MARK: - Init

    init(persistenceController: PersistenceControllerProtocol) {
        self.persistenceController = persistenceController
    }

    // MARK: - Functions

    func createModul(with note: ToDos) -> AnyView {
        let interactor = DetailNoteInteractor(selectedNote: note, persistenceController: persistenceController)
        let router = DetailNoteRouter()
        let presenter = DetailNotePresenter(interactor: interactor, router: router)
        return AnyView(DetailNote(presenter: presenter))
    }
}
