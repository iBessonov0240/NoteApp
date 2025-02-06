import XCTest
import CoreData
@testable import NoteApp

class DetailNoteInteractorTests: XCTestCase {

    class MockPersistenceController: PersistenceControllerProtocol {
        var container: NSPersistentContainer

        init() {
            container = NSPersistentContainer(name: "MockContainer")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("Ошибка инициализации контейнера: \(error)")
                }
            }
        }

        func saveContext() throws {
            try container.viewContext.save()
        }

        func fetchData<T: NSFetchRequestResult>(for request: NSFetchRequest<T>) -> [T] {
            do {
                return try container.viewContext.fetch(request)
            } catch {
                return []
            }
        }
    }

    var interactor: DetailNoteInteractor!
    var mockNote: ToDos!
    var mockPersistenceController: MockPersistenceController!

    override func setUp() {
        super.setUp()
        mockPersistenceController = MockPersistenceController()

        let context = mockPersistenceController.container.viewContext

        mockNote = ToDos(
            id: 1,
            todo: "Test Note",
            completed: false,
            description: "Test description",
            timestemp: "01/01/2024"
        )

        try? context.save()

        interactor = DetailNoteInteractor(selectedNote: mockNote, persistenceController: mockPersistenceController)
    }

    override func tearDown() {
        super.tearDown()
        interactor = nil
        mockPersistenceController = nil
        mockNote = nil
    }

    func testGetNote() {
        let note = interactor.getNote()
        XCTAssertEqual(note.todo, "Test Note")
        XCTAssertEqual(note.description, "Test description")
    }
}
