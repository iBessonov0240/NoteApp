import Foundation

protocol MainProtocol {
    func fetchNotes(completion: @escaping ([ToDos]) -> Void)
    func addNote(newNote: ToDos, complition: @escaping () -> Void)
    func deleteNote(_ note: ToDos, complition: @escaping () -> Void)
    func fetchNotesFromAPI(completion: @escaping ([ToDos]) -> Void)
}
