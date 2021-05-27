//
//  NetworkManager.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import Foundation
import Combine

private var BACKEND_URL: String {
    return "https://api.yelp.com"
}

class NetworkManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    @Published var result: NetworkResult = NetworkResult(businesses: [], region: Region(center: Center(latitude: 33.7886375, longitude: -117.9632285))) {
        didSet {
            didChange.send(self)
            self.businesses = result.businesses
        }
    }
    
    @Published var businesses: [Business] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        fetch(center: self.result.region.center)
    }
    
    func fetch(term: String = "delis", center: Center) {
        let query = "term=\(term)&latitude=\(center.latitude)&longitude=\(center.longitude)"
        guard let url = URL(string: "\(BACKEND_URL)/v3/businesses/search?\(query)") else { return }
        
        var request = URLRequest(url: url);
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(self.getAuthHeader(), forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let data = data else { return }
            let result = try? JSONDecoder().decode(NetworkResult.self, from: data)
            guard let result = result else { return }
            DispatchQueue.main.async {
                self.result = result
            }
        }.resume()
    }
    
    func getAuthHeader() -> String {
        let apiKey = self.getApiKey()
        return "Bearer \(apiKey)"
    }
    
    func getApiKey() -> String {
        return "eT6PM6WVekGSNeU7mzYr34mf4CbNjck_fVcdJb8M5c-SwMHkQgkYX0RR1K0CrO0v7uPL2BI_NLWw7wEzdXmJ2Gwi0I-aZiN6jPiVKL57rmLnv_5hjxOS_kbz8FWsYHYx"
    }
}
