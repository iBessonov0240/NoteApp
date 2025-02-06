import SwiftUI

struct MainFooterView: View {

    // MARK: - Properties

    @ObservedObject var presenter: MainPresenter

    // MARK: - View
    
    var body: some View {
        HStack {

            Text("\(presenter.notes.count) задач")
                .foregroundColor(ColorManager().white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.leading, LayoutConstants.buttonWidth)

            Button(action: {
                presenter.addNote()
            }) {
                Image("newNote")
                    .resizable()
                    .scaledToFit()
                    .frame(width: LayoutConstants.buttonWidth, height: LayoutConstants.buttonImageHeight)
            }
        }
        .padding(.horizontal)
        .frame(height: LayoutConstants.buttonHeight)
        .background(ColorManager().gray)
    }
}

#Preview {
    MainFooterView(presenter: MainPresenter(interactor: MainInteractor(persistenceController: PersistenceController()), router: MainRouter(persistenceController: PersistenceController())))
}

// MARK: - Layouts

private struct LayoutConstants {
    static let buttonHeight: CGFloat = 49
    static let buttonWidth: CGFloat = 68
    static let buttonImageHeight: CGFloat = 28
}
