import Foundation

final class APIManager: APIManagerProtocol {

    static let shared = APIManager()
    private let baseURL = URL(string: "https://dummyjson.com/todos")

    private init() {}

    func fetchTodo(completion: @escaping (Result<[ToDos], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL ?? URL(fileURLWithPath: "")) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(NoteEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
