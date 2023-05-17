//
//  GridView.swift
//  SpotifyClone
//
//  Created by Gamal Kubeyev on 04.05.2023.
//

import SwiftUI

struct GridView<Data, Content, Header>: View where Data: Hashable, Content: View, Header: View {
    enum Direction {
        case horizontal([GridItem])
        case vertical([GridItem])
        
        var scrollViewDirection: Axis.Set {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }

    let data: [Data]
    let direction: GridView.Direction
    let spacing: CGFloat
    let content: (Data) -> Content
    let header: () -> Header
    
    init(data: [Data],
         direction: Direction = .horizontal([GridItem(.flexible())]),
         spacing: CGFloat = 10,
         @ViewBuilder content: @escaping (Data) -> Content,
         @ViewBuilder header: @escaping () -> Header = { EmptyView() }) {
        self.data = data
        self.direction = direction
        self.spacing = spacing
        self.content = content
        self.header = header
    }
    
    var body: some View {
        ScrollView(direction.scrollViewDirection) {
            VStack {
                header()
                switch direction {
                case .vertical(let columns):
                    LazyVGrid(columns: columns, alignment: .leading, spacing: spacing, content: contentItems)
                        .padding(spacing/2)
                case .horizontal(let rows):
                    LazyHGrid(rows: rows, alignment: .center, spacing: spacing, content: contentItems)
                        .padding(spacing/2)
                }
            }
        }
    }

    private func contentItems() -> some View {
        ForEach(data, id: \.self) { item in
            content(item)
        }
    }
}

//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView()
//    }
//}
