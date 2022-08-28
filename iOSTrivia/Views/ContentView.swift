//
//  ContentView.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/25/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var lightMode: Bool = true
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color(hex: 0x333333)
                .ignoresSafeArea([.all])
            NavigationView {
                ZStack {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(viewModel.categories, id:\.id) { category in
                                NavigationLink(destination: TriviaOptionsView(triviaCategory: category)) {
                                    GeometryReader { geometry in
                                        HStack() {
                                            Text(viewModel.formatCategoryName(name: category.name))
                                                .font(.system(size: 26, weight: .bold))
                                                .foregroundColor(Color.white)
                                                .padding()
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        .frame(width: geometry.size.width * 0.85, height: 100)
                                        .background(Color.yellow)
                                        .cornerRadius(15)
                                        .frame(width: geometry.size.width) // Center horizontally
                                        
                                    } // End of GeometryReader
                                    .frame(height: 100)
                                } // End of NavigationLink
                            } // End of ForEach
                        } // End of VStack
                    } // End of Scrollview
                } // End of ZStack
                .navigationTitle("Trivia Game")
                .toolbar {
                    ToolbarItem {
                        Button(action: { lightMode.toggle() }) {
                            Image(systemName: lightMode == true ? "sun.max" : "sun.max.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(lightMode == true ? Color.black : Color.white)
                        }
                    }
                }
                .onAppear {
                    Task {
                        await viewModel.setupCategories()
                    }
                }
            } // End of NavigationView
            .navigationViewStyle(.stack) // Prevents constraint error
        } // End of Root ZStack
        .preferredColorScheme(lightMode == true ? .light : .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}