import SwiftUI

enum RMImageType {
    case avatar
    
    var image: Image {
        switch self {
        case .avatar:
            return Image("Placeholder")
        }
    }
}

struct RMAsyncImage<V: ViewModifier>: View {
    
    private var url: URL?
    private var placeholderImage: RMImageType
    private var customVM: V?
    private var genericVM: RMAsyncImageViewModifier?
    
    var body: some View {
        CachedAsyncImage(url: url, urlCache: .imageCache) { image in
            if let genericVM = genericVM {
                getImageWithCustomModifierIfNeeded(image: image)
                    .modifier(genericVM)
            } else {
                getImageWithCustomModifierIfNeeded(image: image)
            }
        } placeholder: {
            if let genericVM = genericVM {
                getImageWithCustomModifierIfNeeded(image: placeholderImage.image)
                    .modifier(genericVM)
            } else {
                getImageWithCustomModifierIfNeeded(image: placeholderImage.image)
            }
        }
    }
    
    init(url: URL? = nil,
         placeholderImage: RMImageType,
         customVM: V? = nil,
         genericVM: RMAsyncImageViewModifier? = nil
    ) {
        self.url = url
        self.placeholderImage = placeholderImage
        self.customVM = customVM
        self.genericVM = genericVM
    }
    
    @ViewBuilder private func getImageWithCustomModifierIfNeeded(image: Image) -> some View {
        if let customVM = customVM {
            image
                .resizable()
                .modifier(customVM)
        } else {
            image
                .resizable()
        }
    }
}

extension RMAsyncImage where V == EmptyModifier {
    init(url: String, placeholder: RMImageType, genericVM: RMAsyncImageViewModifier? = nil) {
        if let url = URL(string: url) {
            self.url = url
        }
        self.placeholderImage = placeholder
        self.genericVM = genericVM
        self.customVM = EmptyModifier()
    }
}

extension RMAsyncImage where V == EmptyModifier {
    init(url: String, placeholder: RMImageType) {
        if let url = URL(string: url) {
            self.url = url
        }
        self.placeholderImage = placeholder
        self.customVM = EmptyModifier()
    }
}

struct RMAsyncImageViewModifier: ViewModifier {

    var aspectRatio: ContentMode?
    var opacity: Double?

    func body(content: Content) -> some View {
        applyIfAspectRatioNeeded(content: content)
            .opacity((opacity) ?? 1)
    }
    
    @ViewBuilder
    private func applyIfAspectRatioNeeded(content: Content) -> some View {
        if let aspectRatio = aspectRatio {
            content
                .aspectRatio(contentMode: aspectRatio)
        } else {
            content
        }
    }
}

//#Preview {
//    RMAsyncImage()
//}
