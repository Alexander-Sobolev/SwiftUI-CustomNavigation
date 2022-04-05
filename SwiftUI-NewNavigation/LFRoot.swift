//
//  LFRoot.swift
//  SwiftUI-NewNavigation
//
//  Created by Alexander Sobolev on 05.04.2022.
//

import SwiftUI
import ComposableNavigator


class LFAlert: ObservableObject {
  @Published var showAlert: Bool = false
  @Published var alert: Alert?
  static let shared = LFAlert()
  
  static func showAlert(alert: Alert) {
    LFAlert.shared.alert = alert
    LFAlert.shared.showAlert = true
  }
}

class LFNavigation: ObservableObject {
  @Published var navigator: Navigator
  @Published var dataSource: Navigator.Datasource
  
  
  init(dataSource: Navigator.Datasource) {
    self.dataSource = dataSource
    self.navigator = Navigator(dataSource: dataSource)
  }
  
  static let shared = LFNavigation(dataSource: Navigator.Datasource(root: ContentView().screen))
  
}



public struct LFRoot<Builder: PathBuilder>: View {
  @ObservedObject private var dataSource: Navigator.Datasource
  private let navigator: Navigator
  private let pathBuilder: Builder
  @State var showAlert = false
  
  public init(
    dataSource: Navigator.Datasource,
    navigator: Navigator,
    pathBuilder: Builder
  ) {
    self.dataSource = dataSource
    self.navigator = navigator
    self.pathBuilder = pathBuilder
  }
  
  public var body: some View {
    if let rootPathComponent = dataSource.path.current.first {
      NavigationView {
        pathBuilder.build(
          pathElement: rootPathComponent
        )
          .alert(isPresented: $showAlert) {
            if let alert = LFAlert.shared.alert {
              return alert
            }
            return Alert(title: Text(""))
            
          }
      }
      .onReceive(LFAlert.shared.$showAlert, perform: { isShowAlert in
        showAlert = isShowAlert
      })
      .environment(
        \.currentScreenID,
         rootPathComponent.id
      )
      .environment(
        \.currentScreen,
         rootPathComponent.content
      )
      .environment(
        \.navigator,
         navigator
      )
      .environmentObject(dataSource)
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}

public extension LFRoot {
  init(
    dataSource: Navigator.Datasource,
    pathBuilder: Builder
  ) {
    self.init(
      dataSource: dataSource,
      navigator: Navigator(dataSource: dataSource),
      pathBuilder: pathBuilder
    )
  }
  
  /// Enable  logging function calls to the Navigator object and path changes.
  func debug() -> LFRoot {
    LFRoot(
      dataSource: dataSource,
      navigator: navigator.debug(),
      pathBuilder: pathBuilder
    )
  }
}

