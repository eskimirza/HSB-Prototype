//
//  SliderView.swift
//  HSB-Prototype
//
//  Created by Eski Mirza on 9/9/20.
//  Copyright © 2020 Eski Mirza. All rights reserved.
//

import SwiftUI

struct SliderView: View {
    @Binding var xOffset: CGFloat
    @Binding var sliderModifier: CGFloat
    @State var isDragged = false
    @State var isHue = false
    @State var isSaturation = false
    @State var isBrightness = false
    @Binding var isEdited: Bool
    var colors = [Color]()
    var sliderTitle = "Slider"
    var trackWidth: CGFloat = 538
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)
                    .frame(width: self.trackWidth, height: 3)
                    
                    Circle()
                        .foregroundColor(Color.black)
                        .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
                        .frame(width: self.isDragged ? 24 : 16, height: self.isDragged ? 24 : 16)
                        .offset(x: self.xOffset)
                        .animation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0))
                    
                    LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)
                        .mask(
                            Circle()
                                .frame(width: self.isDragged ? 24 : 16, height: self.isDragged ? 24 : 16)
                                .scaledToFit()
                                .offset(x: self.xOffset)
                                .animation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0))
                        )
                        .frame(width: self.trackWidth + 100 , height: 24)
                    
                    Circle()
                        .foregroundColor(Color.black.opacity(0.1))
                        .frame(width: self.isDragged ? 24 : 16, height: self.isDragged ? 24 : 16)
                        .offset(x: self.xOffset)
                        .animation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0))
                        .gesture(
                            DragGesture().onChanged { value in
                                if value.location.x <= self.trackWidth/2 && value.location.x >= -(self.trackWidth/2){
                                    self.xOffset = value.location.x

                                    if self.isHue {
                                        self.sliderModifier = ((value.location.x + (self.trackWidth/2)) / (self.trackWidth) - 0.5) * 360
                                    } else if self.isSaturation {
                                        self.sliderModifier = (value.location.x + (self.trackWidth/2)) / (self.trackWidth) * 5
                                    } else if self.isBrightness {
                                        self.sliderModifier = (value.location.x + (self.trackWidth/2)) / (self.trackWidth) - 0.5
                                    }
                                    
                                    print(value.location.x, self.sliderModifier, (value.location.x + (self.trackWidth/2)) / (self.trackWidth))
                                }
                                self.isDragged = true
                            }
                            .onEnded{ value in
                                self.isDragged = false
                                
                                if self.xOffset != 0 {
                                    self.isEdited = true
                                } else {
                                    self.isEdited = false
                                }
                            }
                        )
                }
                .frame(width: self.trackWidth)
                
                Text(self.sliderTitle)
                    .foregroundColor(.gray)
                    .frame(width: 100, alignment: .leading)
                    .padding(.leading, 10)
            }
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(xOffset: .constant(0), sliderModifier: .constant(0), isDragged: false, isHue: true, isSaturation: false, isBrightness: false, isEdited: .constant(false), colors: [.red, .purple, .blue, .green, .yellow, .orange, .red], sliderTitle: "Hue", trackWidth: 538)
    }
}
