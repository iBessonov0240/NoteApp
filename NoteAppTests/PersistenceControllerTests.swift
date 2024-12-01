import XCTest
import CoreData
@testable import NoteApp

final class PersistenceControllerTests: XCTestCase {

    var persisteceController: PersistenceController!

    override func setUp() {
        super.setUp()
        persisteceController = PersistenceController()
    }

    func testSaveAndFetchNotes() {
        let context = persisteceController.container.viewContext

        let note = Note(context: context)
        note.id = 1
        note.todoTitle = "Test Note"
        note.todoDescription = "Description"
        note.completed = false
        note.timestemp = "01/01/24"

        XCTAssertNoThrow(try persisteceController.saveContext())

        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        let fetchedNotes = persisteceController.fetchData(for: fetchRequest)

        XCTAssert(fetchedNotes.contains { $0.todoTitle == "Test Note" }, "Saved ote should be present in fetched results")
    }

    func testDeleteNote() {
        let context = persisteceController.container.viewContext

        let note = Note(context: context)
        note.id = 1
        note.todoTitle = "Test Note"

        XCTAssertNoThrow(try persisteceController.saveContext(), "Failed to save context before deletion")

        context.delete(note)
        XCTAssertNoThrow(try persisteceController.saveContext(), "Failed to save context after deletion")
    }
}
