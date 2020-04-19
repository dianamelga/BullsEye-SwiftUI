//
//  ContentView.swift
//  Bullseye
//
//  Created by Diana Melgarejo on 4/16/20.
//  Copyright © 2020 Diana Melgarejo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .modifier(Shadow())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .modifier(Shadow())
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
                .modifier(Shadow())
        }
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            // Target Row
            HStack {
                Text("Put the Bullseye as close as you can to:").modifier(LabelStyle())
                
                Text("\(target)").modifier(ValueStyle())
                
            }
            Spacer()
            // Slider Row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            Spacer()
            // Button row
            Button(action: {
                self.alertIsVisible = true
                
            }) {
                Text("Hit me").modifier(ButtonLargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) {()-> Alert in
                return Alert(
                    title: Text("\(alertTitle())"),
                    message: Text("The slider's value is \(sliderRoundedValue()).\n" +
                        "You scored \(self.pointForCurrentRound()) points this round."),
                    dismissButton: .default(Text("Awesome!")) {
                        self.score += self.pointForCurrentRound()
                        self.target = Int.random(in:1...100)
                        self.round += 1
                    })
            }
            .background(Image("Button"))
            
            Spacer()
            // Score row
            HStack {
                Button(action: {
                    self.startOver()
                }) {
                    HStack {
                      Image("StartOverIcon")
                      Text(/*@START_MENU_TOKEN@*/"Start Over"/*@END_MENU_TOKEN@*/).modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button"))
                Spacer()
                Text(/*@START_MENU_TOKEN@*/"Score"/*@END_MENU_TOKEN@*/).modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                    Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button"))
            }
            .padding(.bottom, 20)
            
            
            
        }.background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
    }
    
    func amountOff() -> Int {
        abs(sliderRoundedValue() - target)
    }
    
    func pointForCurrentRound() -> Int {
        var bonusPoints = 0
        let points = 100 - amountOff()
        
        if(amountOff() == 0) {
            bonusPoints = 100
        }else if(amountOff() == 1) {
            bonusPoints = 50
        }
        
        return  points + bonusPoints
    }
    
    func sliderRoundedValue() -> Int {
        Int(sliderValue.rounded())
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        if(difference == 0) {
            title = "Perfect!"
        }else if (difference < 5) {
            title = "You almost had it!"
        }else if (difference <= 10) {
            title = "Not bad."
        }else {
            title = "Are you even trying?"
        }
        
        return title
    }
    
    func startOver() {
        score = 0
        round = 1
        target = Int.random(in:1...100)
        sliderValue = 50.0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
