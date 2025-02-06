import SwiftUI

@main
struct NoteAppApp: App {

    let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            let mainView = MainModule(persistenceController: persistenceController)
            mainView.createModul()
                .accentColor(ColorManager().yellow)
        }
    }
}
