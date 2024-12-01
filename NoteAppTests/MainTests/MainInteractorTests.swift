import XCTest
@testable import NoteApp

final class MainInteractorTests: XCTestCase {

    var interactor: MainInteractor!
    var persistenceController: PersistenceController!

    override func setUp() {
        persistenceController = PersistenceController(inMemory: true)
        interactor = MainInteractor(persistenceController: persistenceController)
    }

    func testAddAndFetchNotes() {
        let newNote = NoteEntity.ToDos(
            id: 1,
            todo: "Test Todo",
            completed: false,
            description: "Description",
            timestemp: "01/01/24"
        )

        let expectation = self.expectation(description: "Add and fetch notes")

        interactor.addNote(newNote: newNote) {
            self.interactor.fetchNotes { notes in
                XCTAssertTrue(notes.contains { $0.todo == "Test Todo" }, "Added note should be present in fetched results")
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 5)
    }
}
