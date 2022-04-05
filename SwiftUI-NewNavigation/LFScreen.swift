//
//  LFScreen.swift
//  SwiftUI-NewNavigation
//
//  Created by Alexander Sobolev on 05.04.2022.
//

import SwiftUI
import Foundation
import ComposableNavigator


class LFScreen<Content: View>: Screen {
  let id = UUID().hashValue
  var presentationStyle: ScreenPresentationStyle = .push
  
  var nested: AnyPathBuilder?
  var view: Content?
  
  init(view: Content? = nil, @NavigationTreeBuilder nesting: (() -> AnyPathBuilder) = {
    AnyPathBuilder(erasing: PathBuilders.empty)
  }) {
    self.nested = nesting()
    self.view = view
  }
  
  struct Builder: NavigationTree {
    var builder: some PathBuilder {
      If { (screen: LFScreen) in
        Screen(LFScreen.self) {
          if let view = screen.view {
            view
          } else {
            EmptyView()
          }
        } nesting: {
          if screen.view != nil {
            if let nesting = screen.nested {
              nesting
            } else {
              AnyPathBuilder(erasing: PathBuilders.empty)
            }
          } else {
            AnyPathBuilder(erasing: PathBuilders.empty)
          }
        }
      }
    }
  }
}

extension LFScreen {
  static func == (lhs: LFScreen, rhs: LFScreen) -> Bool {
    lhs.id == rhs.id
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

