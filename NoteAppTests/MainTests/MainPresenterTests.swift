import XCTest
import CoreData
@testable import NoteApp

final class MainPresenterTests: XCTestCase {

    var presenter: MainPresenter!
    var interactor: MainInteractor!
    var router: MainRouter!
    var persistenceController: PersistenceControllerProtocol!

    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController()

        interactor = MainInteractor(persistenceController: persistenceController)
        router = MainRouter()
        presenter = MainPresenter(interactor: interactor, router: router)
    }

    override func tearDown() {
        presenter = nil
        interactor = nil
        router = nil
        persistenceController = nil
        super.tearDown()
    }

    func testFiltersNotes() {
        let note1 = ToDos(id: 1, todo: "First Todo", completed: false, description: "First", timestemp: "01/01/24")
        let note2 = ToDos(id: 2, todo: "Second Todo", completed: false, description: "Second", timestemp: "01/01/24")
        presenter.notes = [note1, note2]

        presenter.text = "First"

        XCTAssertEqual(presenter.filteredNotes.count, 1)
        XCTAssertEqual(presenter.filteredNotes.first?.todo, "First Todo")
    }

    func testAddNote() {
        let initialCount = presenter.notes.count
        presenter.addNote()

        XCTAssertEqual(presenter.notes.count, initialCount + 1)
    }
}
