import SwiftUI

struct CharacterDisclosureView<ViewModel: CharacterItemViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                ScrollView {
                    avatarImage()
                        .frame(width: proxy.size.width, height: proxy.size.width)
                    Spacer(minLength: 20)
                    
                    HStack {
                        Text(viewModel.data.name)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Species:")
                                .foregroundStyle(.secondary)
                            Text(viewModel.data.species)
                                .bold()
                            Spacer()
                        }
                        
                        HStack {
                            Text("Gender:")
                                .foregroundStyle(.secondary)
                            Text(viewModel.data.gender)
                                .bold()
                            Spacer()
                        }
                        
                        HStack {
                            Text("Status:")
                                .foregroundStyle(.secondary)
                            Text(viewModel.data.status)
                                .bold()
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider().padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top) {
                            Text("Type:")
                                .foregroundStyle(.secondary)
                            Text(viewModel.data.type ?? "N/A")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Last Seen:")
                                .foregroundStyle(.secondary)
                            Text(viewModel.data.location.name)
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Episodes:")
                                .foregroundStyle(.secondary)
                            Text("\(viewModel.data.episode.count)")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Created:")
                                .foregroundStyle(.secondary)
                            Text(viewModel.created())
                                .bold()
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Character Info")
                    .font(.headline)
                    .bold()
            }
        }
        
    }
    
    @ViewBuilder func avatarImage() -> some View {
        ZStack {
            VStack {
                RMAsyncImage(url: viewModel.data.image, placeholder: .avatar)
                    .clipShape(RoundedRectangle(cornerRadius: 28.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
            }
        }
    }
}

#Preview {
    CharacterDisclosureView(viewModel: CharacterItemViewModel(data: CharacterEntityMock()))
}
