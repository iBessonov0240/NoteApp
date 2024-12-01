import CoreData

struct PersistenceController: PersistenceControllerProtocol {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NoteApp")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - PersistenceControllerProtocol Methods

    func saveContext() throws {

        let context = container.viewContext
        if context.hasChanges {
            try context.save()
        }
    }

    func fetchData<T: NSFetchRequestResult>(for request: NSFetchRequest<T>) -> [T] {
        
        let context = container.viewContext
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
            return []
        }
    }
}
