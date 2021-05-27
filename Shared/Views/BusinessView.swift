//
//  RestaurantView.swift
//  Yelper (iOS)
//
//  Created by Duong Nguyen on 5/24/21.
//

import CoreData
import SwiftUI

private var GOOGLE_MAPS_URL: String {
    return "https://www.google.com/maps/place/"
}

struct BusinessView: View {
    @State var showingFavoriteResultAlert = false
    @State var googleMapsURL: URL = URL(string: GOOGLE_MAPS_URL)!
    @State var favorite: Favorite?
    @State var favoriteIcon: String = "heart"
    @State var addedToFavorite = false

    private var business: Business

    init(business: Business) {
        self.business = business
        parseFavorite(business)
        parseAddress(business)
    }
    
    func parseAddress(_ business: Business) {
        if business.location.display_address.count > 0 {
            let address = business.location.display_address.reduce("", { "\($0), \($1)" })
            if (address.count > 0) {
                let transformedAddresss = address.replacingOccurrences(of: " ", with: "+")
                if let url = URL(string: "\(GOOGLE_MAPS_URL)\(transformedAddresss)") {
                    self.googleMapsURL = url
                    return
                }
                
            }
        }
    }
    
    func parseFavorite(_ business: Business) {
        let favorites = CoreDataManager.shared.fetchFavorites()
        for favorite in favorites {
            print(favorite.businessId ?? "")
            print(business.id)
            if favorite.businessId == business.id {
                print("Found \(favorite.businessId ?? "")")
                self.favorite = favorite
                self.addedToFavorite = true
                self.favoriteIcon = "heart.fill"
                return
            }
        }
    }
    
    func handleFavorite() {
        if (self.addedToFavorite) {
            guard let favorite = self.favorite else { return }
            CoreDataManager.shared.deleteFavorite(favorite) { err in
                if let err = err {
                    print("\(err)")
                    return
                }
                
                print("Deleted \(favorite.businessId ?? "")")
                self.favorite = nil
                self.favoriteIcon = "heart"
                self.addedToFavorite = false
                self.showingFavoriteResultAlert.toggle()
            }
        } else {
            CoreDataManager.shared.addFavorite(businessId: business.id) { favorite, err in
                if let err = err {
                    print("\(err)")
                    return
                }
                                
                print("Added \(favorite?.businessId ?? "")")
                self.favorite = favorite
                self.favoriteIcon = "heart.fill"
                self.addedToFavorite = true
                self.showingFavoriteResultAlert.toggle()
            }
        }
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    RemoteImage(url: business.image_url)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
                        .clipped()
                    VStack(alignment: .leading) {
                        Link("Get directions to \(business.name)", destination: googleMapsURL).foregroundColor(.white).padding(12).background(Color.blue).cornerRadius(10).clipped()
                        HStack(alignment: .center) {
                            Text("\(getMiles(meters: business.distance)) mile\(getMiles(meters: business.distance) == 1 ? "" : "s")").fontWeight(.bold).padding(.trailing, -4)
                            Text("away from me")
                        }.padding(.top, 4)
                        HStack(alignment: .center) {
                            Text("\(business.review_count)").fontWeight(.bold).padding(.trailing, -4)
                            Text("Review\(business.review_count == 1 ? "" : "s")")
                        }.padding(.top, 4)
                        HStack {
                            ForEach((1...Int(business.rating)).reversed(), id: \.self) { _ in
                                Image(systemName: "star.fill").resizable().aspectRatio(contentMode: .fit).frame(width: 44, height: 44).foregroundColor(.pink).padding(.zero)
                            }
                        }.padding(.top, 8)
                    }.padding()
                }
            }.navigationBarItems(
                trailing: Button(action: handleFavorite) {
                    Image(systemName: favoriteIcon).font(.system(size: 28, weight: .regular)).padding(.trailing, -4)
                }.alert(isPresented: $showingFavoriteResultAlert, content: {
                    Alert(
                        title: Text(addedToFavorite ? "Added to favorites" : "Removed from favorites"),
                        dismissButton: .default(Text("Ok!"))
                    )
                }))
        }
    }
}
