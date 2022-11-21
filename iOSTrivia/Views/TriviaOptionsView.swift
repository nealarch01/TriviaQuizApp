//
//  TriviaOptionsViewView.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import SwiftUI

struct TriviaOptionsView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var isLoading: Bool = false

    let triviaCategory: TriviaCategory // Required parameter
    
    let column = [
        GridItem(.flexible(maximum: 150)),
        GridItem(.flexible(maximum: 150))
    ]
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea([.all])
            VStack(spacing: 35) {
                VStack {
                    Text("Difficulty")
                        .font(.system(size: 26, weight: .medium))
                    
                    LazyVGrid(columns: column, spacing: 20) {
                        OptionButton(
                            title: "Any 🤠",
                            action: {
                                viewModel.updateDifficulty(selected: .any)
                            },
                            isSelected: viewModel.isDifficultyActive(.any))
                        
                        
                        OptionButton(
                            title: "Easy 😃",
                            action: {
                                viewModel.updateDifficulty(selected: .easy)
                            },
                            isSelected: viewModel.isDifficultyActive(.easy)
                        )
                        
                        
                        OptionButton(
                            title: "Medium 🙂",
                            action: {
                                viewModel.updateDifficulty(selected: .medium)
                            },
                            isSelected: viewModel.isDifficultyActive(.medium)
                        )
                        
                        
                        OptionButton(
                            title: "Hard 🤔",
                            action: {
                                viewModel.updateDifficulty(selected: .hard)
                            },
                            isSelected: viewModel.isDifficultyActive(.hard)
                        )
                    } // LazyVGrid
                }
                
                
                VStack {
                    Text("Question Type")
                        .font(.system(size: 26, weight: .medium))
                    
                    LazyVGrid(columns: column, spacing: 20) {
                        OptionButton(
                            title: "Both",
                            action: {
                                viewModel.updateTriviaType(selected: .both)
                            },
                            isSelected: viewModel.isTriviaTypeActive(.both)
                        )
                        
                        
                        OptionButton(
                            title: "Multiple Choice",
                            action: {
                                viewModel.updateTriviaType(selected: .multipleChoice)
                            },
                            isSelected: viewModel.isTriviaTypeActive(.multipleChoice)
                        )
                    } // LazyVGrid
                    
                    OptionButton(
                        title: "True / False",
                        action: {
                            viewModel.updateTriviaType(selected: .trueFalse)
                        },
                        isSelected: viewModel.isTriviaTypeActive(.trueFalse)
                    )
                }
                
                
                VStack {
                    Text("Number of questions")
                        .font(.system(size: 26, weight: .medium))
                    
                    HStack {
                        Group {
                            OptionButton(title: "5", action: { viewModel.updateQuantity(selected: 5) }, isSelected: viewModel.isQuantitySelected(5))
                            OptionButton(title: "10", action: { viewModel.updateQuantity(selected: 10) }, isSelected: viewModel.isQuantitySelected(10))
                            OptionButton(title: "15", action: { viewModel.updateQuantity(selected: 15) }, isSelected: viewModel.isQuantitySelected(15))
                            OptionButton(title: "20", action: { viewModel.updateQuantity(selected: 20) }, isSelected: viewModel.isQuantitySelected(20))
                        }
                        .frame(width: 80)
                    }
                }
                
                NavigationLink(destination: QuestionsView(questions: $viewModel.questions), isActive: $viewModel.successfulLoad) {
                    Text("Start!")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(Color.backgroundColor)
                        .frame(width: 200, height: 50)
                        .background(Color.yellow)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .onTapGesture {
                            Task {
                                isLoading.toggle()
                                await viewModel.fetchTriviaQuestions(triviaCategory: self.triviaCategory)
                                isLoading.toggle()
                            }
                        }
                        .overlay(alignment: .trailing) {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(Color.backgroundColor)
                                    .frame(width: 50, height: 50)
                                    .scaleEffect(1.4)
                            }
                        }
                        .padding([.top])
                } // NavigationLink
                
                if viewModel.errorMessage != "" {
                    Text(viewModel.errorMessage)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.red)
                }
                
                Spacer()
            } // VStack
            .navigationTitle(triviaCategory.name)
            .navigationBarTitleDisplayMode(.inline)
        } // Root ZStack
    }
}

struct TriviaOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TriviaOptionsView(triviaCategory: TriviaCategory())
                .preferredColorScheme(.dark)
        }
    }
}
