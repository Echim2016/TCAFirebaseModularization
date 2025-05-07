//
//  FirebaseClientLive.swift
//  ModuleDemoApp
//
//  Created by Yi-Chin Hsu on 2025/5/7.
//

import Dependencies
import FirebaseClient
import FirebaseCore
import FirebaseFirestore

extension FirebaseClient: Dependencies.DependencyKey {
  public static let liveValue: FirebaseClient = .init(
    configure: {
      FirebaseApp.configure()
    },
    getDocuments: { collectionName in
      let db = Firestore.firestore()
      let snapshot = try await db.collection(collectionName).getDocuments()
      return snapshot.documents.map(\.documentID)
    }
  )
}
