import CoreData
import SwiftUI

class MainInteractor: MainProtocol {

    // MARK: - Property

    private let persistenceController: PersistenceControllerProtocol
    private let queue = DispatchQueue(label: "note", qos: .userInitiated)

    // MARK: - Init

    init(persistenceController: PersistenceControllerProtocol) {
        self.persistenceController = persistenceController
    }

    // MARK: - Functions

    /// Core Data
    func fetchNotes(completion: @escaping ([NoteEntity.ToDos]) -> Void) {
        queue.async {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Note.id, ascending: false)]

            let fetchedEntities: [Note] = self.persistenceController.fetchData(for: fetchRequest)

            let todos = fetchedEntities.map {
                NoteEntity.ToDos(
                    id: Int($0.id),
                    todo: $0.todoTitle,
                    completed: $0.completed,
                    description: $0.todoDescription,
                    timestemp: $0.timestemp
                )
            }
            DispatchQueue.main.sync {
                completion(todos)
            }
        }
    }

    func addNote(newNote: NoteEntity.ToDos, complition: @escaping () -> Void) {
        queue.async {
            let context = self.persistenceController.container.viewContext
            let newTodo = Note(context: context)
            newTodo.id = Int64(newNote.id)
            newTodo.todoTitle = newNote.todo
            newTodo.completed = newNote.completed
            newTodo.todoDescription = newNote.description
            newTodo.timestemp = newNote.timestemp

            self.saveContext()

            DispatchQueue.main.async {
                complition()
            }
        }
    }

    func deleteNote(_ note: NoteEntity.ToDos, complition: @escaping () -> Void) {
        queue.async {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let context = self.persistenceController.container.viewContext
            fetchRequest.predicate = NSPredicate(format: "id == %lld", note.id)

            do {
                if let savedNote = try context.fetch(fetchRequest).first {
                    context.delete(savedNote)
                    self.saveContext()
                }
            } catch {
                print("Error fetching todos for deletion: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                complition()
            }
        }
    }

    private func saveContext() {
        do {
            try persistenceController.saveContext()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }

    /// API
    func fetchNotesFromAPI(completion: @escaping ([NoteEntity.ToDos]) -> Void) {
        queue.async {
            APIManager.shared.fetchTodo { result in
                switch result {
                case .success(let todos):
                    DispatchQueue.main.async {
                        completion(todos)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("Error fetching todos from API: \(error.localizedDescription)")
                        completion([])
                    }
                }
            }
        }
    }
}
