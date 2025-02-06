import SwiftUI

struct DetailNote: View {

    // MARK: - Property

    @ObservedObject var presenter: DetailNotePresenter

    // MARK: - Constants
    
    private let padding: CGFloat = 20
    private let spacing: CGFloat = 8
    private let titleFont = Font.system(size: 34, weight: .bold)
    private let descriptionFont = Font.system(size: 16, weight: .regular)
    private let dateFont = Font.system(size: 12, weight: .regular)

    // MARK: - View

    var body: some View {
        NavigationView {
            VStack(spacing: spacing) {

                CustomTextField(
                    text: Binding(
                        get: { presenter.selectedNote.todo ?? "" },
                        set: { presenter.selectedNote.todo = $0 }
                    ),
                    font: titleFont
                )

                Text(presenter.selectedNote.timestemp ?? "")
                    .foregroundColor(ColorManager().whiteAlpha)
                    .font(dateFont)
                    .frame(maxWidth: .infinity, alignment: .leading)

                CustomTextField(
                    text: Binding(
                        get: { presenter.selectedNote.description ?? "" },
                        set: { presenter.selectedNote.description = $0 }
                    ),
                    font: descriptionFont
                )

                Spacer()
            }
            .padding(.top, padding)
            .padding(.leading, padding)
            .background(ColorManager().background)
        }
        .onDisappear {
            presenter.cancelUpdateTimer()
            presenter.updateNote()
        }
    }
}

#Preview {
    DetailNote(presenter: DetailNotePresenter(interactor: DetailNoteInteractor(selectedNote: ToDos.init(id: 1, todo: "Title", completed: false, description: "Description", timestemp: "02/04/24"), persistenceController: PersistenceController()), router: DetailNoteRouter()))
}
