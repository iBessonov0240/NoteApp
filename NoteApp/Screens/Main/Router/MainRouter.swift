import SwiftUI
import CoreData

class MainRouter: MainRouterProtocol {

    private var persistenceController: PersistenceControllerProtocol = PersistenceController.shared

    func createModul() -> AnyView {
        let interactor = MainInteractor(persistenceController: persistenceController)
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        return AnyView(Main(presenter: presenter))
    }

    func navigateToDetail(with note: NoteEntity.ToDos) -> AnyView {
        let detailNote = DetailNoteRouter()
        return detailNote.createModul(with: note)
    }
}
