//
//  ContentView.swift
//  HSB-Prototype
//
//  Created by Eski Mirza on 7/9/20.
//  Copyright © 2020 Eski Mirza. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var hueModifier: CGFloat = 0
    @State var saturationModifier: CGFloat = 1
    @State var brightnessModifier: CGFloat = 0
    @State var isHueEdited: Bool = false
    @State var isSaturationEdited: Bool = false
    @State var isBrightnessEdited: Bool = false
    @State var hueSliderOffset: CGFloat = 0
    @State var saturationSliderOffset: CGFloat = 0
    @State var brightnessSliderOffset: CGFloat = 0
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Image("Neon-Source")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)
                .hueRotation(Angle(degrees: Double(hueModifier)))
                .saturation(Double(saturationModifier))
                .brightness(Double(brightnessModifier))
    
            VStack(spacing:0) {
                TopBarView()
                    .offset(x: 0, y: -2)
                
                Text("Hue, Saturation, Brightness")
                    .frame(width: screen.width)
                    .padding(.vertical, 5)
                    .foregroundColor(.gray)
                    .background(BlurView(style: .systemThinMaterialDark))
                    .offset(x: 0, y: -2)
                    
                
                Spacer()
                
                HStack {
                    VStack (spacing: 2) {
                        Button(action: {
                            self.hueModifier = 0
                            self.saturationModifier = 1
                            self.brightnessModifier = 0
                            
                            self.hueSliderOffset = 0
                            self.saturationSliderOffset = 0
                            self.brightnessSliderOffset = 0
                            
                            self.isHueEdited = false
                            self.isSaturationEdited = false
                            self.isBrightnessEdited = false
                        }) {
                            Text("Reset")
                                .frame(width: 140, height: 40)
                                .background(Color("buttonBackground2"))
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                                .opacity(isHueEdited || isSaturationEdited || isBrightnessEdited ? 1 : 0.5)
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Preview")
                                .frame(width: 140, height: 40)
                                .background(Color("buttonBackground2"))
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                        }
                        
                        Button(action: {}) {
                            Text("Undo")
                                .frame(width: 140, height: 40)
                                .background(Color("buttonBackground2"))
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Redo")
                                .frame(width: 140, height: 40)
                                .background(Color("buttonBackground2"))
                                .foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                            .opacity(0.5)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: -20) {
                        SliderView(xOffset: $hueSliderOffset, sliderModifier: $hueModifier, isHue: true, isEdited: $isHueEdited, colors: [.red, .purple, .blue, .green, .yellow, .orange, .red], sliderTitle: "Hue")
                        
                        SliderView(xOffset: $saturationSliderOffset, sliderModifier: $saturationModifier, isSaturation: true, isEdited: $isSaturationEdited, colors: [.gray, .red], sliderTitle: "Saturation")
                        
                        SliderView(xOffset: $brightnessSliderOffset, sliderModifier: $brightnessModifier, isBrightness: true, isEdited: $isBrightnessEdited, colors: [.black, .white], sliderTitle: "Brightness")
                    }


                    
                    Spacer()
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 24)
                .padding(.top, 16)
                .frame(maxWidth: screen.width, maxHeight: 186)
                .background(BlurView(style: .dark))
            }
        }
        .statusBar(hidden: true)
    }
}

extension View {
    public func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
      self.overlay(overlay).mask(self)
    }
}

let screen = UIScreen.main.bounds

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.previewLayout(.fixed(width: 1366, height: 1024))
    }
}
