//
//  App.swift
//  ModuleDemoApp
//
//  Created by Yi-Chin Hsu on 2025/5/7.
//

import ComposableArchitecture
import Home
import Settings
import SwiftUI

public struct AppView: View {
  public var body: some View {
    TabView {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house")
        }

      SettingsView(
        store: Store(
          initialState: Settings.State(),
          reducer: {
            Settings()
          }
        )
      )
      .tabItem {
        Label("Settings", systemImage: "gearshape")
      }
    }
  }

  public init() {}
}

#Preview {
  AppView()
}
