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
    @State var trackWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing:0) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)
                    .frame(height: 3)
                    .padding(.horizontal, 16)
                    
                    Circle()
                        .foregroundColor(Color.black)
                        .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
                        .frame(width: self.isDragged ? 24 : 16, height: self.isDragged ? 24 : 16)
                        .offset(x: self.xOffset)
                        .animation(.spring(response: 0.2, dampingFraction: 0.8, blendDuration: 0))
                    
                    LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)
                        .mask(
                            Circle()
                                .frame(width: self.isDragged ? 24 : 16, height: self.isDragged ? 24 : 16)
                                .scaledToFit()
                                .offset(x: self.xOffset)
                                .animation(.spring(response: 0.2, dampingFraction: 0.8, blendDuration: 0))
                        )
                        .frame(height: 24)
                    
                    Circle()
                        .foregroundColor(Color.black.opacity(0.1))
                        .frame(width: self.isDragged ? 24 : 16, height: self.isDragged ? 24 : 16)
                        .offset(x: self.xOffset)
                        .animation(.spring(response: 0.2, dampingFraction: 0.8, blendDuration: 0))
                        
                }
                .frame(maxWidth: .infinity)
                .onAppear {
                    self.trackWidth = geometry.size.width - 100 - 32 // track - text - padding
                }
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged { value in
                        self.sliderOffset(value)
                        self.isDragged = true
                    }
                    .onEnded{ value in
                        self.sliderOffset(value)
                        self.isDragged = false
                        
                        if self.xOffset != 0 {
                            self.isEdited = true
                        } else {
                            self.isEdited = false
                        }
                        
                        if value.location.x < 16 {
                            self.xOffset = -(self.trackWidth/2)
                        } else if value.location.x > self.trackWidth + 16 {
                            self.xOffset = self.trackWidth/2
                        }
                        
                    }
                )

                Text(self.sliderTitle)
                    .foregroundColor(.gray)
                    .frame(width: 100, alignment: .leading)
            }
        }
    }
    
    fileprivate func sliderOffset(_ value: DragGesture.Value) {
        if value.location.x >= 16 && value.location.x <= self.trackWidth+16{
            self.xOffset = value.location.x - (self.trackWidth/2) - 16
            if self.isHue {
                self.sliderModifier = ((value.location.x) / (self.trackWidth) - 0.5) * 360
            } else if self.isSaturation {
                self.sliderModifier = (value.location.x) / (self.trackWidth) * 5
            } else if self.isBrightness {
                self.sliderModifier = (value.location.x) / (self.trackWidth) - 0.5
            }
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(xOffset: .constant(0), sliderModifier: .constant(0), isDragged: false, isHue: true, isSaturation: false, isBrightness: false, isEdited: .constant(false), colors: [.red, .purple, .blue, .green, .yellow, .orange, .red], sliderTitle: "Hue", trackWidth: 538)
    }
}
