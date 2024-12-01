import XCTest
@testable import NoteApp

final class APIManagerTests: XCTestCase {

    func testFetchTodoSuccess() {

        let testAPIManager = APIManager(baseURL: "https://dummyjson.com/todos")
        let expectation = self.expectation(description: "Fetch todos succeeds")

        testAPIManager.fetchTodo { result in
            switch result {
            case .success(let todos):
                XCTAssertFalse(todos.isEmpty, "Todos list should not empty")
            case .failure(let error):
                XCTFail("Expected success, got error: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testFetchTodoFailure() {

        let testAPIManager = APIManager(baseURL: "https://invalid-url.com")
        let expectation = self.expectation(description: "Fetch todos fails")

        testAPIManager.fetchTodo { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure:
                XCTAssert(true, "Expected failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}
