import Foundation

struct ToDos: Decodable, Identifiable {
    var id: Int
    var todo: String?
    var completed: Bool
    var description: String?
    var timestemp: String?
}
