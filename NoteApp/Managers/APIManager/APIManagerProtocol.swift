protocol APIManagerProtocol {
    func fetchTodo(completion: @escaping (Result<[NoteEntity.ToDos], Error>) -> Void)
}
