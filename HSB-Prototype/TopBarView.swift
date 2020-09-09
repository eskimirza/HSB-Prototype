//
//  TopBarView.swift
//  HSB-Prototype
//
//  Created by Eski Mirza on 9/9/20.
//  Copyright © 2020 Eski Mirza. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        HStack {
            HStack(spacing: 24) {
                Text("Gallery")
                    .foregroundColor(.gray)
                
                Button(action: {}) {
                    Image("icon_settings")
                        .foregroundColor(Color("buttonForeground"))
                        .frame(width: 32, height: 32)
                        .background(Color("buttonBackground"))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Image("icon_magic_wand")
                        .foregroundColor(Color("buttonForeground"))
                        .frame(width: 32, height: 32)
                        .background(Color("buttonBackground"))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Image("icon_settings")
                        .foregroundColor(Color("buttonForeground"))
                        .frame(width: 32, height: 32)
                        .background(Color("buttonBackground"))
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Image("icon_arrow")
                        .foregroundColor(Color("buttonForeground"))
                        .frame(width: 32, height: 32)
                        .background(Color("buttonBackground"))
                        .clipShape(Circle())
                }
            }
            
            Spacer()
            
            HStack(spacing: 24) {
                Button(action: {}) {
                    Image("icon_erase")
                        .renderingMode(.original)
                        .frame(width: 32, height: 32)
                }
                
                Button(action: {}) {
                    Image("icon_layers")
                        .renderingMode(.original)
                        .frame(width: 32, height: 32)
                }
                
                Button(action: {}) {
                    Image("icon_erase")
                        .renderingMode(.original)
                        .frame(width: 32, height: 32)
                }
                
                Button(action: {}) {
                    Image("icon_layers")
                        .renderingMode(.original)
                        .frame(width: 32, height: 32)
                }
                
                Circle()
                    .frame(width: 28, height: 28)
                    .foregroundColor(.pink)
            }
        }
        .padding(.leading, 24)
        .padding(.trailing, 8)
        .frame(width: screen.width, height: 44)
        .background(BlurView(style: .systemMaterialDark))
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
