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
  
  var asModalScreen: LFScreen<Self> {
    return selfScreen
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
  
  func openModal<SomeType: View>(with destinationScreen: LFScreen<SomeType>) {
    let screen = destinationScreen
    screen.presentationStyle = .sheet(allowsPush: true)
    go(to: screen.eraseToAnyScreen())
  }
  
  func dismiss() {
    if let rootPathComponent = LFNavigation.shared.dataSource.path.current.last {
      LFNavigation.shared.navigator.dismiss(screen: rootPathComponent.content)
    }
  }
  
  func dismiss<Content: View>(to screen: Content) {
    let rootPathComponent = LFNavigation.shared.dataSource.path.current
    for navigationScreen in rootPathComponent {
      if navigationScreen.content.is(LFScreen<Content>.self) {
        LFNavigation.shared.navigator.goBack(to: navigationScreen.content)
        break
      }
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
