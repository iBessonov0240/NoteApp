import SwiftUI

struct MainNotesList: View {

    // MARK: - Properties

    @ObservedObject var presenter: MainPresenter

    // MARK: - View

    var body: some View {

        List {
            ForEach(presenter.filteredNotes) { note in
                MainListCell(
                    title: note.todo,
                    description: note.description,
                    date: note.timestemp,
                    completed: note.completed
                )
                .listRowInsets(EdgeInsets())
                .contentShape(Rectangle())
                .onTapGesture {
                    presenter.didSelectNote(note)
                }
                .listRowSeparator(.hidden)
                .contextMenu {
                    Button {
                        presenter.didSelectNote(note)
                    } label: {
                        Label("Редактировать", image: "edit")
                    }

                    Button {
                        presenter.selectedNote = note
                        presenter.isShareSheetPresented = true
                    } label: {
                        Label("Поделиться", image: "export")
                    }

                    Button(role: .destructive) {
                        presenter.deleteNote(note)
                    } label: {
                        Label("Удалить", image: "trash")
                    }
                }
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let note = presenter.filteredNotes[index]
                    presenter.deleteNote(note)
                }
            }
        }
        .sheet(isPresented: $presenter.isShareSheetPresented) {
            if let note = presenter.selectedNote {
                ShareSheet(activityItems: [note.todo ?? "No title", note.description ?? "Description"])
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
        .scrollContentBackground(.hidden)
        .padding(.top, LayoutConstants.top)
        .padding(.bottom, LayoutConstants.buttom)
        .scrollIndicators(.hidden)
        .listStyle(.plain)
    }
}

#Preview {
    MainNotesList(presenter: MainPresenter(interactor: MainInteractor(persistenceController: PersistenceController()), router: MainRouter(persistenceController: PersistenceController())))
}

// MARK: - Layouts

private struct LayoutConstants {
    static let top: CGFloat = 16
    static let buttom: CGFloat = 25
}
