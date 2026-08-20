import Foundation
import RMCore
import RMDomain

enum AppDependencies {
    static func makeCharactersListViewModel() -> CharactersListViewModel {
        let networkSession = NetworkSessionImplementation()
        let service = LoadCharactersServiceImplementation(networkSession: networkSession)
        let repository = CharactersRepositoryImplementation(service: service)
        let useCase = DefaultCharactersListUseCase(repository: repository)
        return CharactersListViewModel(useCase: useCase)
    }
}
