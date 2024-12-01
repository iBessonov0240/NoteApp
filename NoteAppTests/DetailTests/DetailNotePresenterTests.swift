import XCTest
@testable import NoteApp
import Combine

class DetailNotePresenterTests: XCTestCase {

    class MockDetailNoteInteractor: DetailNoteProtocol {
        var note: NoteEntity.ToDos

        init(note: NoteEntity.ToDos) {
            self.note = note
        }

        func getNote() -> NoteEntity.ToDos {
            return note
        }

        func updateNote(title: String?, description: String?) {
            note.todo = title ?? note.todo
            note.description = description ?? note.description
        }
    }

    var presenter: DetailNotePresenter!
    var interactor: MockDetailNoteInteractor!
    var mockNote: NoteEntity.ToDos!

    override func setUp() {
        super.setUp()
        mockNote = NoteEntity.ToDos(id: 1, todo: "Test Note", completed: false, description: "Test description", timestemp: "01/01/2024")

        interactor = MockDetailNoteInteractor(note: mockNote)
        presenter = DetailNotePresenter(interactor: interactor, router: DetailNoteRouter())
    }

    func testSelectedNote() {
        XCTAssertEqual(presenter.selectedNote.todo, "Test Note")
        XCTAssertEqual(presenter.selectedNote.description, "Test description")
    }

    func testUpdateNote() {
        presenter.selectedNote.todo = "Updated Title"
        presenter.selectedNote.description = "Updated Description"

        presenter.updateNote()

        XCTAssertEqual(interactor.getNote().todo, "Updated Title")
        XCTAssertEqual(interactor.getNote().description, "Updated Description")
    }
}
