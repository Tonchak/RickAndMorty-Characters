import SwiftUI

struct CharactersListView<VM: CharactersListViewModel>: View {

    @StateObject var viewModel: VM

    var body: some View {
        NavigationStack {
            content
                .navigationTitle(viewModel.navigationTitle)
                .task {
                    await viewModel.loadNextPage()
                }
        }
    }
}

private extension CharactersListView {

    @ViewBuilder
    var content: some View {
        if viewModel.loadedList.isEmpty {
            emptyContent
        } else {
            characterList
        }
    }

    @ViewBuilder
    var emptyContent: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let errorMessage = viewModel.errorMessage {
            errorState(message: errorMessage)
        } else {
            Text("No characters")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    var characterList: some View {
        List {
            ForEach(viewModel.loadedList, id: \.id) { item in
                let model = CharacterItemViewModel(data: item)
                NavigationLink(destination: CharacterDisclosureView(viewModel: model)) {
                    CharacterItemView(viewModel: model)
                }
                .listRowSeparator(.hidden)
                .onAppear {
                    if viewModel.isLastItem(item) {
                        viewModel.loadNextPageIfNeeded()
                    }
                }
            }

            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .listRowSeparator(.hidden)
            } else if viewModel.errorMessage != nil {
                Button("Retry") {
                    Task { await viewModel.loadNextPage() }
                }
                .frame(maxWidth: .infinity)
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }

    func errorState(message: String) -> some View {
        VStack(spacing: 12) {
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
            Button("Retry") {
                Task { await viewModel.loadNextPage() }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CharactersListView(viewModel: CharactersListViewModel(useCase: PreviewCharactersListUseCase()))
        //.environment(\.sizeCategory, .accessibilityLarge)
}
