//
//  TabBarView.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/26/21.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var selectedIndex = 0
    @State var tabBarItems = ["magnifyingglass", "heart"]
    
    var body: some View {
        VStack {
            ZStack {
                if selectedIndex == 0 {
                    ExploreView().environment(\.managedObjectContext, viewContext)
                } else {
                    FavoritesView().environment(\.managedObjectContext, viewContext)
                }
            }
            Spacer()
            HStack(alignment: .center, spacing: 8) {
                ForEach(0..<tabBarItems.count) { idx in
                    Spacer()
                    Image(systemName: tabBarItems[idx]).font(.system(size: 28, weight: .regular)).foregroundColor(idx == selectedIndex ? .pink : .gray).onTapGesture {
                        selectedIndex = idx
                    }
                    Spacer()
                }
            }.background(Color(.systemBackground)).padding(.bottom, 4)
        }
    }
}
