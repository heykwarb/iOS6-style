//
//  ContentView.swift
//  iOS6 style
//
//  Created by Yohey Kuwa on 2023/03/24.
//

import SwiftUI

struct ContentView: View {
    let gradient1 = LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.3), .gray.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
    
    let artworks = ["kickback", "man on the moon 3", "TLOP serif ver"]
    var body: some View {
        ZStack{
            gradient1
            ZStack{
                Color.black.opacity(0.4)
                Image("BG")
                    .resizable()
                    .blendMode(.multiply)
                
                HStack{
                    ForEach(0..<3){num in
                        Image(artworks[num])
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(4)
                        .shadow(radius: 2)
                        ///.padding()
                    }
                }
            }
            .clipShape(ContainerRelativeShape())
            .padding(2)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

