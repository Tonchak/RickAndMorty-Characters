import SwiftUI

@main
struct RMCharactersApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersListView(viewModel: CharactersListViewModel())
        }
    }
}
