//
//  Settings.swift
//  ModuleDemoApp
//
//  Created by Yi-Chin Hsu on 2025/5/7.
//

import ComposableArchitecture
import FirebaseClient
import SwiftUI

@Reducer
public struct Settings: Sendable {
  @ObservableState
  public struct State: Equatable {
    var content: String
    
    public init(content: String = "content not found") {
      self.content = content
    }
  }

  public enum Action: ViewAction {
    case didReceiveDocumentIDs(Result<[String], Error>)
    case view(View)

    public enum View {
      case getDocumentIDsButtonTapped
    }
  }

  public init() {}

  @Dependency(\.firebaseClient) var firebaseClient

  public var body: some Reducer<State, Action> {
    Reduce<State, Action> { state, action in
      switch action {
      case let .didReceiveDocumentIDs(result):
        switch result {
        case let .success(ids):
          state.content = ids.joined()
          return .none
        case .failure:
          return .none
        }
      case .view(.getDocumentIDsButtonTapped):
        return .run { send in
          await send(
            .didReceiveDocumentIDs(
              Result {
                try await self.firebaseClient.getDocuments(collectionName: "user")
              }
            )
          )
        }
      }
    }
  }
}

@ViewAction(for: Settings.self)
public struct SettingsView: View {
  @Bindable public var store: StoreOf<Settings>

  public init(store: StoreOf<Settings>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      Text(store.content)
        .font(.title3)
        .bold()
      Button("Get Document IDs") {
        send(.getDocumentIDsButtonTapped)
      }
    }
  }
}

#Preview {
  SettingsView(
    store: Store(
      initialState: Settings.State(),
      reducer: {
        Settings()
      }
    ) {
      $0.firebaseClient = .previewValue
    }
  )
}
