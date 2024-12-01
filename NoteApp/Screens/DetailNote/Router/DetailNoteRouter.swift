import SwiftUI
import CoreData

class DetailNoteRouter: DetailNoteRouterProtocol {

    private var persistenceController: PersistenceControllerProtocol = PersistenceController.shared

    func createModul(with note: NoteEntity.ToDos) -> AnyView {
        let interactor = DetailNoteInteractor(selectedNote: note, persistenceController: persistenceController)
        let router = DetailNoteRouter()
        let presenter = DetailNotePresenter(interactor: interactor, router: router)
        return AnyView(DetailNote(presenter: presenter))
    }
}
