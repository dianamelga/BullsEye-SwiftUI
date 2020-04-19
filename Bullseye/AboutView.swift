//
//  AboutView.swift
//  Bullseye
//
//  Created by Diana Melgarejo on 4/19/20.
//  Copyright © 2020 Diana Melgarejo. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    struct HeaderTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
                .padding(.bottom, 20)
                .padding(.top, 20)
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            
        }
    }
    
    struct ContentTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.black)
                .padding(.bottom, 20)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            
        }
    }

    
    var body: some View {
        Group {
        VStack {
            Text("🎯 Bullseye 🎯").modifier(HeaderTextStyle())
            Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                .modifier(ContentTextStyle())
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
            .modifier(ContentTextStyle())
            Text("Enjoy!")
            .modifier(ContentTextStyle())
        }.background(Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0))
        .navigationBarTitle("About Bullseye")
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
        .previewLayout(.fixed(width: 896, height: 414))
        
    }
}
