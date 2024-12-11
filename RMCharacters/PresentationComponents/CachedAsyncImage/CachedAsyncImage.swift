import SwiftUI

struct CachedAsyncImage<Content: View>: View {

    @State private var phase: AsyncImagePhase = .empty

    private let url: URL?
    private let urlSession: URLSession
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    var body: some View {
        content(phase)
            .animation(transaction.animation, value: phase.image)
            .task(id: url) {
                await load(url: url)
            }
    }

    init<I, P>(url: URL?,
               urlCache: URLCache = .shared,
               @ViewBuilder content: @escaping (Image) -> I,
               @ViewBuilder placeholder: @escaping () -> P
    ) where Content == _ConditionalContent<I, P>, I: View, P: View {
        self.init(url: url, urlCache: urlCache) { phase in
            if let image = phase.image {
                content(image)
            } else {
                placeholder()
            }
        }
    }

    init(url: URL?,
         urlCache: URLCache = .shared,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        self.url = url
        self.urlSession =  URLSession(configuration: configuration)
        self.transaction = transaction
        self.content = content
    }

    private func load(url: URL?) async {
        do {
            guard let url = url else { return }
            let request = URLRequest(url: url)
            let (data, _) = try await urlSession.data(for: request)
            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                phase = .success(image)
            } else {
                throw AsyncImage<Content>.LoadingError()
            }
        } catch {
            phase = .failure(error)
        }
    }
}

private extension AsyncImage {
    struct LoadingError: Error {}
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
