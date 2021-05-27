//
//  ImageLoader.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else { return }
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Text
    var failure: Text

    var body: some View {
        switch loader.state {
        case .loading:
            return AnyView(loading)
        case .failure:
            return AnyView(failure)
        default:
            if let image = UIImage(data: loader.data) {
                return AnyView(Image(uiImage: image).resizable())
            } else {
                return AnyView(failure)
            }
        }
    }

    init(url: String, loading: Text = Text("Loading..."), failure: Text = Text("Failed to load image.")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
}
