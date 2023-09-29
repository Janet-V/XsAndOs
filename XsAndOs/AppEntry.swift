//
//  XsAndOsApp.swift
//  XsAndOs
//
//  Created by Janet Victoria on 9/26/23.
//

import SwiftUI

@main
struct AppEntry: App {
    @AppStorage("yourName") var yourName = ""
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            if yourName.isEmpty{
                YourNameView()
            }else{
                StartView(yourName: yourName)
                    .environmentObject(game)
            }
        }
    }
}
