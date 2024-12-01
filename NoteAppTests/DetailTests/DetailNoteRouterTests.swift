import XCTest
import CoreData
@testable import NoteApp
import SwiftUI

class DetailNoteRouterTests: XCTestCase {

    var router: DetailNoteRouter!
    var persistenceController: PersistenceController!
    var mockNote: NoteEntity.ToDos!

    override func setUp() {
        super.setUp()

        persistenceController = PersistenceController()
        router = DetailNoteRouter()

        mockNote = NoteEntity.ToDos(id: 1, todo: "Test Note", completed: false, description: "Test description", timestemp: "01/01/2024")
    }

    func testCreateModule() {
        let module = router.createModul(with: mockNote)

        XCTAssertNotNil(module)
    }
}
