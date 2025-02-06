import Foundation
import SwiftUI

class MainPresenter: ObservableObject {

    // MARK: - Property

    private let interactor: MainProtocol
    private let router: MainRouterProtocol

    @Published var text: String = "" {
        didSet {
            filterNotes()
        }
    }
    @Published var notes: [ToDos] = []
    @Published var filteredNotes: [ToDos] = []
    @Published var selectedNote: ToDos?
    @Published var isDetailPresented = false
    @Published var isShareSheetPresented = false
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true

    // MARK: - Init

    init(interactor: MainProtocol, router: MainRouterProtocol ) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Functions

    func loadNotes() {
        interactor.fetchNotes { [weak self] todos in
            guard let self = self else { return }

            self.notes = todos
            self.filterNotes()
        }
    }

    func filterNotes() {
        if text.isEmpty {
            filteredNotes = notes
        } else {
            filteredNotes = notes.filter { $0.todo?.localizedCaseInsensitiveContains(text) ?? false }
        }
    }

    func addNote() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        
        let newNote = ToDos(
            id: Int(Date().timeIntervalSince1970),
            todo: "No title",
            completed: false,
            description: "Description",
            timestemp: dateFormatter.string(from: Date())
        )
        notes.insert(newNote, at: 0)

        interactor.addNote(newNote: newNote) { [weak self] in
            self?.filterNotes()
        }
    }

    func deleteNote(_ note: ToDos) {
        interactor.deleteNote(note) { [weak self] in
            self?.loadNotes()
        }
    }

    func didSelectNote(_ note: ToDos) {
        selectedNote = note
        isDetailPresented = true
    }

    func navigateToDetail() -> AnyView? {
        guard let note = selectedNote else { return nil }
        return router.navigateToDetail(with: note)
    }

    func fetchNotesFromAPI() async {
        interactor.fetchNotesFromAPI { [weak self] todos in
            guard let self = self else { return }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"

            for todo in todos {
                let newNote = ToDos(
                    id: todo.id,
                    todo: todo.todo ?? "No title",
                    completed: todo.completed,
                    description: todo.description ?? "Description",
                    timestemp: todo.timestemp ?? dateFormatter.string(from: Date())
                )
                interactor.addNote(newNote: newNote) { [weak self] in
                    self?.loadNotes()
                }
            }
        }
    }
}
