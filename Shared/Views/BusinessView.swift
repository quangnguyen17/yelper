//
//  RestaurantView.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import SwiftUI

struct RestaurantView: View {
    var business: Business
    
    init(business: Business) {
        self.business = business
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    RemoteImage(url: business.image_url)
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .cornerRadius(20)
                        .clipped()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                ForEach((1...Int(business.rating)).reversed(), id: \.self) { _ in
                                    Image(systemName: "heart.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 24, height: 24).foregroundColor(.pink)
                                }
                            }.padding(.bottom)
                            AddressView(display_address: business.location.display_address)
                            Text(business.name).font(.title).foregroundColor(.white).fontWeight(.bold)
                        }
                        Spacer()
                    }.padding()
                }
            }
        }.navigationTitle(Text(business.name))
    }
}
