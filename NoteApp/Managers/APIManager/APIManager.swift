import Foundation

final class APIManager: APIManagerProtocol {

    static let shared = APIManager()
    private var baseURL: String

    init(baseURL: String = "https://dummyjson.com/todos") {
        self.baseURL = baseURL
    }

    func fetchTodo(completion: @escaping (Result<[NoteEntity.ToDos], Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let components = URLComponents(string: self.baseURL),
                  let url = components.url else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badURL)))
                }
                return
            }

            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(NoteEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.todos ?? []))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
