import SwiftUI

@main
struct NoteAppApp: App {
    let mainView = MainRouter()

    var body: some Scene {
        WindowGroup {
            mainView.createModul()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .accentColor(ColorManager().yellow)
        }
    }
}
