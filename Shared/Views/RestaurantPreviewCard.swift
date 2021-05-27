//
//  RestaurantPreviewCard.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import SwiftUI

struct RestaurantPreviewCard: View {
    var business: Business
    
    init(business: Business) {
        self.business = business
    }
    
    func getBusinessView() -> some View {
        return BusinessView(business: business)
            .navigationTitle(business.name)
            .navigationBarTitleDisplayMode(.inline)
    }
    
    var body: some View {
        NavigationLink(destination: getBusinessView()) {
            ZStack {
                RemoteImage(url: business.image_url)
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .cornerRadius(20)
                    .clipped()
                LinearGradient(gradient: Gradient(colors: [Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0)), Color(UIColor(red: 0, green: 0, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .cornerRadius(20)
                    .clipped()
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            ForEach((1...Int(business.rating)).reversed(), id: \.self) { _ in
                                Image(systemName: "star.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 32, height: 32).foregroundColor(.pink)
                            }
                        }.padding(.bottom)
                        Text("\(business.location.display_address[0]), \(business.location.display_address[1])").foregroundColor(.white)
                        Text(business.name).font(.title).foregroundColor(.white).fontWeight(.bold)
                    }
                    Spacer()
                }.padding()
            }.padding(.horizontal)
            .padding(.bottom, 8)
            .cornerRadius(24)
        }
    }
}
