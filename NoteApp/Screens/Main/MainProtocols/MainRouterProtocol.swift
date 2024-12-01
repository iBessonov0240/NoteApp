import SwiftUI

protocol MainRouterProtocol {
    func createModul() -> AnyView
    func navigateToDetail(with note: NoteEntity.ToDos) -> AnyView
}
