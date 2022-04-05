//
//  LFNavigation.swift
//  SwiftUI-NewNavigation
//
//  Created by Alexander Sobolev on 05.04.2022.
//

import Foundation
import ComposableNavigator


class LFNavigation: ObservableObject {
  @Published var navigator: Navigator
  @Published var dataSource: Navigator.Datasource
  
  init(dataSource: Navigator.Datasource) {
    self.dataSource = dataSource
    self.navigator = Navigator(dataSource: dataSource)
  }
  
  static let shared = LFNavigation(dataSource: Navigator.Datasource(root: ContentView().screen))
  
}
