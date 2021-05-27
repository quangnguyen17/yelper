//
//  ContentView.swift
//  Shared
//
//  Created by Duong Nguyen on 5/24/21.
//

import SwiftUI

struct ExploreView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var networkManager = NetworkManager()
    @StateObject var locationManager = LocationManager()
    @State private var searchText: String = ""
        
    init() {
        UINavigationBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().tintColor = .systemPink
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Let's find a place to eat! 🍔")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .onChange(of: searchText) { _ in
                            guard let coordinate = locationManager.coordinate else { return }
                            networkManager.fetch(term: searchText, center: coordinate)
                        }
                    
                    HStack {
                        TextField("Find you favorite restaurant...", text: $searchText)
                            .padding(.vertical)
                            .padding(.horizontal, 20)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(32)
                            .shadow(color: Color(UIColor(white: 0, alpha: 0.1)), radius: 12, x: 0, y: 0)
                    }.padding(.horizontal)
                        .padding(.bottom, 8)
                    
                    ForEach(networkManager.result.businesses, id: \.id) { business in
                        RestaurantPreviewCard(business: business)
                    }
                }.padding(.vertical, 8)
            }.navigationTitle(Text("Explore"))
        }
    }
}
