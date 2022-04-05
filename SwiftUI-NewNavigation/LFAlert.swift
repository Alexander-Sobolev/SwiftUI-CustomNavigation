//
//  LFAlert.swift
//  SwiftUI-NewNavigation
//
//  Created by Alexander Sobolev on 05.04.2022.
//

import Foundation
import SwiftUI

class LFAlert: ObservableObject {
  @Published var showAlert: Bool = false
  @Published var alert: Alert?
  static let shared = LFAlert()
  
  static func showAlert(alert: Alert) {
    LFAlert.shared.alert = alert
    LFAlert.shared.showAlert = true
  }
}
