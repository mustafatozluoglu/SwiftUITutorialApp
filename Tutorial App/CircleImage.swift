//
//  CircleImage.swift
//  Tutorial App
//
//  Created by Mustafa Said Tozluoglu on 28.11.2024.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("mst")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: 7)
    }}

#Preview {
    CircleImage()
}
