import XCTest
@testable import NoteApp
import SwiftUI

class DetailNoteViewTests: XCTestCase {

    var persistenceController: PersistenceControllerProtocol!

    func testViewRendering() {
        let note = NoteEntity.ToDos(id: 1, todo: "Test Note", completed: false, description: "Test description", timestemp: "01/01/2024")
        persistenceController = PersistenceController()
        let interactor = DetailNoteInteractor(selectedNote: note, persistenceController: persistenceController)
        let presenter = DetailNotePresenter(interactor: interactor, router: DetailNoteRouter())
        let view = DetailNote(presenter: presenter)

        let viewController = UIHostingController(rootView: view)

        XCTAssertNotNil(viewController)
    }
}
