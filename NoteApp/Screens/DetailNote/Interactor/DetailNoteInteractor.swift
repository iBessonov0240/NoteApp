import CoreData
import SwiftUI

class DetailNoteInteractor: DetailNoteProtocol {

    // MARK: - Property

    private var selectedNote: NoteEntity.ToDos
    private let persistenceController: PersistenceControllerProtocol
    private let queue = DispatchQueue(label: "todos", qos: .userInteractive)

    // MARK: - Init

    init(selectedNote: NoteEntity.ToDos, persistenceController: PersistenceControllerProtocol) {
        self.selectedNote = selectedNote
        self.persistenceController = persistenceController
    }

    // MARK: - Functions

    func getNote() -> NoteEntity.ToDos {
        selectedNote
    }

    func updateNote(title: String?, description: String?) {
        queue.async { [weak self] in
            guard let self = self else { return }
            guard let note = fetchNote(by: selectedNote.id) else {
                print("Note with ID \(self.selectedNote.id) not found.")
                return
            }

            note.todoTitle = title?.isEmpty == false ? title : "Untitled"
            note.todoDescription = description?.isEmpty == false ? description : "No description"
            note.timestemp = self.getCurrentTimestamp()

            self.saveContext()
        }
    }

    private func fetchNote(by id: Int) -> Note? {
        let context = persistenceController.container.viewContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %lld", Int64(id))

        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Failed to fetch note: \(error.localizedDescription)")
            return nil
        }
    }

    private func saveContext() {
        do {
            try persistenceController.saveContext()
        } catch {
            print("Failed to save note: \(error.localizedDescription)")
        }
    }

    private func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"

        return dateFormatter.string(from: Date())
    }
}
