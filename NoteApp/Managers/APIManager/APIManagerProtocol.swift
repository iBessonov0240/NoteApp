protocol APIManagerProtocol {
    func fetchTodo(completion: @escaping (Result<[ToDos], Error>) -> Void)
}
