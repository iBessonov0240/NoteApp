import Foundation

protocol MainProtocol {
    func fetchNotes(completion: @escaping ([NoteEntity.ToDos]) -> Void)
    func addNote(newNote: NoteEntity.ToDos, complition: @escaping () -> Void)
    func deleteNote(_ note: NoteEntity.ToDos, complition: @escaping () -> Void)
    func fetchNotesFromAPI(completion: @escaping ([NoteEntity.ToDos]) -> Void)
}
