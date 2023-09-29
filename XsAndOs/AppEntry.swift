//
//  XsAndOsApp.swift
//  XsAndOs
//
//  Created by Janet Victoria on 9/26/23.
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
