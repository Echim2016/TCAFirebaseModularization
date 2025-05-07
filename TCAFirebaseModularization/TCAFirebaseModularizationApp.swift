//
//  TCAFirebaseModularizationApp.swift
//  TCAFirebaseModularization
//
//  Created by Yi-Chin Hsu on 2025/5/7.
//

import SwiftUI
import App
import Dependencies
import FirebaseClientLive

@main
struct TCAFirebaseModularizationApp: App {
  @Dependency(\.firebaseClient) var firebaseClient
  
  var body: some Scene {
    WindowGroup {
      AppView()
    }
  }
  
  init() {
//    firebaseClient.configure()
  }
}
