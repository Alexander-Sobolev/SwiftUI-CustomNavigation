//
//  ScreenView.swift
//  SwiftUI-NewNavigation
//
//  Created by Alexander Sobolev on 05.04.2022.
//

import Foundation
import ComposableNavigator
import SwiftUI

protocol ScreenView: View {
  var navigationBuilder: AnyPathBuilder { get set }
}

extension ScreenView {
  private var selfScreen: LFScreen<Self> {
    return LFScreen<Self>.init(view: self) {
      self.navigationBuilder
    }
  }
  var screen: AnyScreen {
    selfScreen.eraseToAnyScreen()
  }
  static var builder: LFScreen<Self>.Builder {
    LFScreen<Self>.Builder()
  }
  
  
  func go(to nextScreen: AnyScreen) {
    if let rootPathComponent = LFNavigation.shared.dataSource.path.current.last {
      LFNavigation.shared.navigator.go(to: nextScreen, on: rootPathComponent.id)
    }
  }
  
  func dismiss() {
    if let rootPathComponent = LFNavigation.shared.dataSource.path.current.last {
      LFNavigation.shared.navigator.dismiss(screen: rootPathComponent.content)
    }
  }
  
  func showAlert(alert: Alert) {
    LFAlert.shared.alert = alert
    LFAlert.shared.showAlert = true
  }
  
  func reloadApp() { dismissToRootScreen() }
  
  func dismissToRootScreen() {
    if let rootPathComponent = LFNavigation.shared.dataSource.path.current.first {
      LFNavigation.shared.navigator.goBack(to: rootPathComponent.content)
    }
  }
  
  
  
}
