import SwiftUI

struct DetailNote: View {

    // MARK: - Property

    @ObservedObject var presenter: DetailNotePresenter

    // MARK: - View

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {

                TextField(
                    "",
                    text: Binding(
                    get: { presenter.selectedNote.todo ?? "" },
                    set: { presenter.selectedNote.todo = $0 }
                ),
                    axis: .vertical
                )
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(ColorManager().white)
                .frame(maxWidth: .infinity)

                Text(presenter.selectedNote.timestemp ?? "")
                    .foregroundColor(ColorManager().whiteAlpha)
                    .font(.system(size: 12, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)

                TextField(
                    "",
                    text: Binding(
                        get: { presenter.selectedNote.description ?? "" },
                        set: { presenter.selectedNote.description = $0 }
                ),
                    axis: .vertical
                )
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(ColorManager().white)
                .frame(maxWidth: .infinity)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button {
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
                        } label: {
                            Text("Done")
                                .foregroundStyle(ColorManager().white)
                        }
                    }
                }

                Spacer()
            }
            .padding(.top, 19)
            .padding(.leading, 20)
            .background(ColorManager().background)
        }
        .onDisappear {
            presenter.cancelUpdateTimer()
            presenter.updateNote()
        }
    }
}

#Preview {
    DetailNote(presenter: DetailNotePresenter(interactor: DetailNoteInteractor(selectedNote: NoteEntity.ToDos.init(id: 1, todo: "Title", completed: false, description: "Description", timestemp: "02/04/24"), persistenceController: PersistenceController.shared), router: DetailNoteRouter()))
}
