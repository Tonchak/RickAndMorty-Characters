import Foundation
import RMDomain

final class CharactersListViewModel: ObservableObject {

    @Published var loadedList = [CharacterEntity]()
    var navigationTitle = "Rick And Morty"
    private var pageNumber = 0

    private let useCase: CharactersListUseCase

    init(useCase: CharactersListUseCase) {
        self.useCase = useCase
    }

    func retrieveNextItems() {
        pageNumber += 1
        Task {
            let result = try await useCase.getCharactersByPage(pageNumber)
            DispatchQueue.main.async {
                self.loadedList.append(contentsOf: result)
            }
        }
    }

    func isLastItem(_ item: CharacterEntity) -> Bool {
        if let lastItem = loadedList.last, lastItem.id == item.id {
            return true
        }
        return false
    }
}
