//
//  FirebaseClient.swift
//  ModuleDemoApp
//
//  Created by Yi-Chin Hsu on 2025/5/7.
//

import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct FirebaseClient: Sendable {
  public var configure: @Sendable () -> Void
  public var getDocuments: @Sendable (_ collectionName: String) async throws -> [String]
}

public extension DependencyValues {
  var firebaseClient: FirebaseClient {
    get { self[FirebaseClient.self] }
    set { self[FirebaseClient.self] = newValue }
  }
}

extension FirebaseClient: TestDependencyKey {
  public static let testValue = Self()
  public static let previewValue = FirebaseClient(
    configure: {},
    getDocuments: { _ in
      ["1", "2", "3", "4", "5", "6"]
    }
  )
}
