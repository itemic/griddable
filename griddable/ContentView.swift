//
//  ContentView.swift
//  griddable
//
//  Created by Terran Kroft on 6/27/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import AppKit
import SwiftUI



struct GridElement: View {
    var content: String
    var backgroundColorArray: [Color] = [.yellow, .green, .blue, .purple]
    var foregroundColorArray: [Color] = [.black, .black, .white, .white]
    @State var index = 0
    
    var body: some View {
        Text(content).font(.system(.body, design: .monospaced))
            .frame(width: 15, height: 15, alignment: .center)
            .padding(5)
            .background(backgroundColorArray[index])
            .foregroundColor(foregroundColorArray[index])
            .onTapGesture {
                self.changeColor()
        }
    
    
    }
    
    func changeColor() {
        self.index = (self.index + 1) % self.backgroundColorArray.count
    }
    
}

struct ContentView: View {
    @State var text = "Test"
    @State var dim = 1.0
    @State var testArray = Array(1...1000).map {"\($0)"}
    
    var body: some View {
        
        VStack(spacing: 5) {
            Text("Test")
            Slider(value: $dim, in: 1...15)
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Data Split")) {
            Text("By character").tag(1)
            Text("By word").tag(2)
            }
            ForEach(0..<Int(dim), id: \.self) {row in
                HStack {
                    ForEach(0..<Int(self.dim), id: \.self) {col in
                        GridElement(content: "\(self.pos(row, col) >= self.testArray.count ? "" : self.testArray[self.pos(row, col)])")
                    }
                }
                
            }
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $text)
            Button(action: bepis) {
            Text("COPY")
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding().onAppear(perform: self.bepis)
    }
    
    
    
    func pos(_ row: Int, _ col: Int) -> Int {
        return row * Int(self.dim) + col
    }
    
    func bepis() -> Void {
        let pasteboard = NSPasteboard.general
//        pasteboard.clearContents()
//        pasteboard.setString(text, forType: .string)
        let element = pasteboard.pasteboardItems!.first!.string(forType: .string)!
        let component = element.components(separatedBy: .whitespacesAndNewlines).joined()
//        print(component)
        let tA = (Array(component))
        testArray = tA.map { String($0) }
//        print(testArray)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
