import XCTest
@testable import RMCharacters
import RMDomain

@MainActor
final class CharactersListViewModelTests: XCTestCase {

    func testAppendsCharactersOnSuccess() async {
        let useCase = MockCharactersListUseCase()
        useCase.pages[1] = CharactersPage(characters: [.preview(id: 1)], nextPageNumber: 2)
        useCase.pages[2] = CharactersPage(characters: [.preview(id: 2)], nextPageNumber: nil)
        let sut = CharactersListViewModel(useCase: useCase)

        await sut.loadNextPage()
        await sut.loadNextPage()

        XCTAssertEqual(sut.loadedList.map(\.id), [1, 2])
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(useCase.requestedPages, [1, 2])
    }

    func testErrorDoesNotAdvancePage() async {
        let useCase = MockCharactersListUseCase()
        useCase.error = StubError.failed
        let sut = CharactersListViewModel(useCase: useCase)

        await sut.loadNextPage()

        XCTAssertTrue(sut.loadedList.isEmpty)
        XCTAssertNotNil(sut.errorMessage)

        useCase.error = nil
        useCase.pages[1] = CharactersPage(characters: [.preview(id: 1)], nextPageNumber: 2)
        await sut.loadNextPage()

        XCTAssertEqual(useCase.requestedPages, [1, 1])
        XCTAssertEqual(sut.loadedList.map(\.id), [1])
        XCTAssertNil(sut.errorMessage)
    }

    func testIgnoresConcurrentLoad() async {
        let useCase = GatedCharactersListUseCase(
            page: CharactersPage(characters: [.preview(id: 1)], nextPageNumber: 2)
        )
        let sut = CharactersListViewModel(useCase: useCase)

        let firstLoad = Task { await sut.loadNextPage() }
        while useCase.callCount == 0 {
            await Task.yield()
        }

        await sut.loadNextPage()
        XCTAssertEqual(useCase.callCount, 1)

        useCase.resume()
        await firstLoad.value
        XCTAssertEqual(sut.loadedList.map(\.id), [1])
    }

    func testStopsWhenThereIsNoNextPage() async {
        let useCase = MockCharactersListUseCase()
        useCase.pages[1] = CharactersPage(characters: [.preview(id: 1)], nextPageNumber: nil)
        let sut = CharactersListViewModel(useCase: useCase)

        await sut.loadNextPage()
        await sut.loadNextPage()

        XCTAssertEqual(useCase.requestedPages, [1])
        XCTAssertFalse(sut.isLoading)
    }
}

private enum StubError: Error {
    case failed
}

private final class MockCharactersListUseCase: CharactersListUseCase {
    var pages: [Int: CharactersPage] = [:]
    var error: Error?
    private(set) var requestedPages: [Int] = []

    func getCharactersByPage(_ pageNumber: Int) async throws -> CharactersPage {
        requestedPages.append(pageNumber)
        if let error {
            throw error
        }
        return pages[pageNumber] ?? CharactersPage(characters: [], nextPageNumber: nil)
    }
}

private final class GatedCharactersListUseCase: CharactersListUseCase {
    private let page: CharactersPage
    private var continuation: CheckedContinuation<CharactersPage, Error>?
    private(set) var callCount = 0

    init(page: CharactersPage) {
        self.page = page
    }

    func getCharactersByPage(_ pageNumber: Int) async throws -> CharactersPage {
        callCount += 1
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
        }
    }

    func resume() {
        continuation?.resume(returning: page)
        continuation = nil
    }
}
