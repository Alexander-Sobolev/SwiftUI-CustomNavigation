//
//  ContentView.swift
//  SwiftUI-NewNavigation
//
//  Created by Alexander Sobolev on 05.04.2022.
//

import SwiftUI
import ComposableNavigator



struct ContentView: ScreenView {
  var navigationBuilder: AnyPathBuilder = .init(erasing: SecondView.builder)
  
  var body: some View {
    VStack {
      Button {
        self.go(to: SecondView().screen)
      } label: {
        Text("Go to second")
      }
      
      Button {
        
        //Так удобнее со вьюхи
        self.showAlert(alert: Alert(title: Text("Test alert")))
        // Это можем вызвать откуда угодно
//        LFAlert.showAlert(alert: Alert(title: Text("Checking")))
      } label: {
        Text("Show alert")
      }
      
      Text("Hello, world!")
        .padding()
    }
    .onAppear {
      print("First screen appeared")
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


struct SecondView: ScreenView {
  var navigationBuilder: AnyPathBuilder = .init(erasing: ThirdView.builder)
  var body: some View {
    VStack {
      Button {
        self.go(to: ThirdView().screen)
      } label: {
        Text("Go to third")
      }
      
      Button {
        self.showAlert(alert: Alert(title: Text("Test alert2")))
      } label: {
        Text("Show alert")
      }
      
      
      Text("Second screen")
        .padding()
      
    }
  }
}

struct ThirdView: ScreenView {
  var navigationBuilder: AnyPathBuilder = .init(erasing: PathBuilders.empty)
  @Environment(\.navigator) private var navigator
  @Environment(\.currentScreen) private var currentScreen
  
  var body: some View {
    VStack {
      Text("Third View")
        .padding()
      Button {
        self.dismiss()
      } label: {
        Text("Dismiss screen")
      }
      
      Button {
        self.reloadApp()
      } label: {
        Text("Dismiss to root")
      }
      
    }
    
  }
}

