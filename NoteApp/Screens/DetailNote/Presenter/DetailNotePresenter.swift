import Combine
import Foundation

class DetailNotePresenter: ObservableObject {

    // MARK: - Property

    private let interactor: DetailNoteProtocol
    private let router: DetailNoteRouterProtocol
    private var cancellable: AnyCancellable?
    @Published var selectedNote: ToDos {
        didSet {
            checkUpdate()
        }
    }

    // MARK: - Init

    init(interactor: DetailNoteProtocol, router: DetailNoteRouterProtocol) {
        self.interactor = interactor
        self.router = router
        self.selectedNote = interactor.getNote()
    }

    private func checkUpdate() {
        cancelUpdateTimer()
        cancellable = Just(())
            .delay(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateNote()
            }
    }

    func cancelUpdateTimer() {
        cancellable?.cancel()
    }

    func updateNote() {
        interactor.updateNote(title: selectedNote.todo, description: selectedNote.description)
    }
}
