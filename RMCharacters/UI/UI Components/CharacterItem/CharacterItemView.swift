import SwiftUI
import RMDomain

struct CharacterItemView<VM: CharacterItemViewModel>: View {

    @StateObject var viewModel: VM
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 2

    var body: some View {
        HStack(alignment: .top) {
            RMAsyncImage(url: viewModel.data.image, placeholder: .avatar)
                .frame(width: 120, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 28.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .overlay {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(
                            Color(.systemGray2), lineWidth: 2
                        )
                }
                .padding(scaledPadding)
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.data.name)
                        .padding(scaledPadding)
                        .font(.title2)
                        .foregroundStyle(Color(.label))
                        .bold()
                    Text(viewModel.data.status + " - " + viewModel.data.species)
                        .padding(scaledPadding)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(Color(.label))
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Last known location:")
                        .padding(scaledPadding)
                        .font(.subheadline)
                        .foregroundStyle(Color(.secondaryLabel))
                    Text(viewModel.data.location.name)
                        .padding(scaledPadding)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(Color(.label))
                }
            }
            Spacer()
        }
    }
}

#Preview {
    CharacterItemView(viewModel: CharacterItemViewModel(data: CharacterEntityMock()))
        //.environment(\.sizeCategory, .accessibilityLarge)
}
