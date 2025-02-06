import SwiftUI

struct Main: View {

    // MARK: - Property

    @ObservedObject var presenter: MainPresenter

    // MARK: - View

    var body: some View {
        NavigationStack {
            VStack {

                MainHeaderView()

                MainSearchBar(text: $presenter.text)

                MainNotesList(presenter: presenter)

                Spacer()

                MainFooterView(presenter: presenter)
            }
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
            .navigationDestination(
                isPresented: $presenter.isDetailPresented
            ) {
                presenter.navigateToDetail()
            }
            .background(ColorManager().background)
            .onAppear {
                if presenter.isFirstLaunch {
                    Task {
                        await presenter.fetchNotesFromAPI()
                    }
                    presenter.isFirstLaunch = false
                }
                presenter.loadNotes()
            }
        }
    }
}

#Preview {
    Main(presenter: MainPresenter(interactor: MainInteractor(persistenceController: PersistenceController()), router: MainRouter(persistenceController: PersistenceController())))
}
