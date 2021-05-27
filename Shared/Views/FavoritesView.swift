//
//  FavoritesView.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/26/21.
//

import CoreData
import SwiftUI

struct FavoritesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var businesses: [Business] = []
    
    func Content() -> some View {
        if self.businesses.count == 0 {
            return AnyView(Text("You don't have any favorites saved yet."))
        }
        
        return AnyView(ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(businesses, id: \.id) { business in
                    RestaurantPreviewCard(business: business)
                }
            }.padding(.vertical, 8)
        })
    }
    
    var body: some View {
        NavigationView {
            Content().navigationTitle(Text("Favorites"))
        }.onAppear {
//            let favorites: [Favorite] = CoreDataManager.shared.fetchFavorites()
        
        }
    }
    
}
