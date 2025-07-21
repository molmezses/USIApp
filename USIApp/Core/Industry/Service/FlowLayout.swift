//
//  FlowLayout.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

import SwiftUI

struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    var data: Data
    var spacing: CGFloat = 8
    var content: (Data.Element) -> Content
    
    @State private var totalHeight: CGFloat = .zero
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.data, id: \.self) { item in
                self.content(item)
                    .padding(.all, 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > geometry.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == data.last {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item == data.last {
                            height = 0
                        }
                        return result
                    })
            }
        }
        .background(GeometryReader { geo in
            Color.clear.preference(key: ViewHeightKey.self, value: geo.size.height)
        })
        .onPreferenceChange(ViewHeightKey.self) { self.totalHeight = $0 }
    }
}

private struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
