import SwiftUI

struct CharactersListView<VM: CharactersListViewModel>: View {

    @StateObject var viewModel: VM

    var body: some View {
        NavigationStack(root: {
            List(viewModel.loadedList, id: \.id) { item in
                let model = CharacterItemViewModel(data: item)
                NavigationLink(destination: CharacterDisclosureView(viewModel: model)) {
                    CharacterItemView(viewModel: model)
                }
                .listRowSeparator(.hidden)
                .onAppear {
                    if viewModel.isLastItem(item) {
                        viewModel.retrieveNextItems()
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(viewModel.navigationTitle)
            .task {
                viewModel.retrieveNextItems()
            }
        })
    }
}

#Preview {
    CharactersListView(viewModel: CharactersListViewModel())
        //.environment(\.sizeCategory, .accessibilityLarge)
}
