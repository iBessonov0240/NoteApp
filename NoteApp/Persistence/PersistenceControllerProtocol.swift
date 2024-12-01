import CoreData

protocol PersistenceControllerProtocol {
    var container: NSPersistentContainer { get }
    func saveContext() throws
    func fetchData<T: NSFetchRequestResult>(for request: NSFetchRequest<T>) -> [T]
}
