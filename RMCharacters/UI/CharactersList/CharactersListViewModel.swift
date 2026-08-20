import Foundation
import RMDomain

@MainActor
final class CharactersListViewModel: ObservableObject {

    @Published var loadedList = [CharacterEntity]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    var navigationTitle = "Rick And Morty"

    private var nextPageNumber: Int? = 1
    private let useCase: CharactersListUseCase

    init(useCase: CharactersListUseCase) {
        self.useCase = useCase
    }

    func loadNextPage() async {
        guard !isLoading, let pageNumber = nextPageNumber else { return }
        isLoading = true
        errorMessage = nil
        do {
            let page = try await useCase.getCharactersByPage(pageNumber)
            loadedList.append(contentsOf: page.characters)
            nextPageNumber = page.nextPageNumber
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func loadNextPageIfNeeded() {
        guard errorMessage == nil else { return }
        Task { await loadNextPage() }
    }

    func isLastItem(_ item: CharacterEntity) -> Bool {
        loadedList.last?.id == item.id
    }
}
