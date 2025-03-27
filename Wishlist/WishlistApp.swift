//
//  WishlistApp.swift
//  Wishlist
//
//  Created by Nicola Buompane on 27/03/25.
//

import SwiftUI
import SwiftData

@main
struct WishlistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Wish.self)
        }
    }
}
