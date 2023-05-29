//
//  ContentView.swift
//  SampleApp
//
//  Created by Gamal Kubeyev on 26.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, there")
            .background(Color.green)
            .padding(10)
            .frame(width: 250, height: 250)
            .background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
