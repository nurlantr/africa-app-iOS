//
//  GalleryView.swift
//  Africa
//
//  Created by Nurlan Turemuratov on 27.07.2023.
//

import SwiftUI

struct GalleryView: View {
    @State private var selectAnimal: String = "lion"
    
    let animals: [Animal] = Bundle.main.decode("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    
    func gridSwitch(){
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false){
            VStack (alignment: .center, spacing: 30) {
                //: IMAGE
                Image(selectAnimal)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                
                //MARK: - SLIDER
                Slider(value: $gridColumn, in: 2...4, step: 1)
                    .padding(.horizontal)
                    .onChange(of: gridColumn, perform: { value in
                        gridSwitch()
                    })
        
                //MARK: - GRID
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(animals) { item in
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .onTapGesture {
                                selectAnimal = item.image
                                haptics.impactOccurred()
                            }
                    } //: LOOP
                } //: GRID
                .animation(.easeIn)
                .onAppear(perform: {
                    gridSwitch()
                })
                
            }//: VSTACK
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
        } //: SCROLL
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
