import Foundation

protocol DetailNoteProtocol {
    func getNote() -> ToDos
    func updateNote(title: String?, description: String?)
}
