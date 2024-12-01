import Foundation

struct NoteEntity: Decodable {

    let todos: [ToDos]?

    struct ToDos: Decodable, Identifiable {

        var id: Int
        var todo: String?
        var completed: Bool
        var description: String?
        var timestemp: String?
    }
}
