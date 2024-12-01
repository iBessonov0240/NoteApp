import Foundation

protocol DetailNoteProtocol {
    func getNote() -> NoteEntity.ToDos
    func updateNote(title: String?, description: String?)
}
