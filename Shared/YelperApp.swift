//
//  YelperApp.swift
//  Shared
//
//  Created by Duong Nguyen on 5/24/21.
//

import SwiftUI

@main
struct YelperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabBarView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

func getMiles(meters: Double) -> Int {
    let val = (meters * 0.000621371192).rounded()
    return Int(val)
}
