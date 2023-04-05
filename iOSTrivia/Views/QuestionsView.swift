//
//  QuestionsView.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import SwiftUI

// MARK: -- AnswerBox

// A box of the answer
fileprivate struct AnswerBox: View {
    // Parameters
    let possibility: Answer
    @Binding var selectedUUID: UUID // Relays to QuestionView of selection is incorrect / correct
    @Binding var clickedComplete: Bool
    @Binding var selectionCorrect: Bool
    
    // Private properties
    @State private var wasSelected: Bool = false // Highlights only the selected box
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Button(action: {
                    if possibility.incorrect == false {
                        selectionCorrect = true
                    }
                    withAnimation(.easeOut(duration: 0.1)) {
                        clickedComplete = true
                        wasSelected = true
                    }
                }) {
                    HStack(spacing: 0) {
                        Text(possibility.text)
                            .font(.system(size: 24, weight: .medium))
                            .minimumScaleFactor(0.3)
                            .lineLimit(nil)
                            .foregroundColor(Color.black)
                            .padding(4)
                            .padding([.leading], wasSelected ? 40 : 0)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            if wasSelected == true {
                                Image(systemName: clickedComplete == true && possibility.incorrect == false ? "checkmark" : "xmark")
                                    .font(.system(size: 28, weight: .bold))
                                    .foregroundColor(Color.white)
                                    .frame(width: 40, height: 40)
                            }
                    }
                    .frame(width: geometry.size.width * 0.9, height: 60)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                            .shadow(color: Color.black.opacity(0.7), radius: 2)
                    }
                } // button
                .background(markCorrect())
                .cornerRadius(12)
                .frame(width: geometry.size.width) // Centers the ZStack
            }
            .frame(height: 60)
        }
    }
    
    func markCorrect() -> Color {
        if clickedComplete == true && possibility.incorrect == false { // Correct; display correct unconditionally
            return Color.green // Returns green color unconditionally after clicked complete was finished
        }
        
        if wasSelected == true && possibility.incorrect == true { // Mark the incorrect button that was selected
            return Color.red // Return red if selected was incorrect
        }
        
        return Color.white // Returns white by default (non-selected)
    }
}

// MARK: -- QustionView

// Displays a singular question and relays back to QuestionsView once selected
fileprivate struct QuestionView: View {
    // Required params:
    let question: String
    let possibilities: Array<Answer>
    @Binding var clicked: Bool
    @Binding var selectionCorrect: Bool
    
    // Properties
    @State private var selectedUUID = UUID()
    
    var body: some View {
        ZStack {
            VStack {
                Text(question)
                    .font(.system(size: 24, weight: .medium))
                    .padding()
                
                // ForEach
                VStack(spacing: 30) {
                    ForEach(possibilities, id: \.uuid) { possibility in
                        AnswerBox(possibility: possibility, selectedUUID: $selectedUUID, clickedComplete: $clicked, selectionCorrect: $selectionCorrect)
                            .disabled(clicked)
                    }
                }
            } // VStack
        } // ZStack
    }
}




// MARK: -- QuestionsView

// View that controls which question to be displayed and redirects to result screen.
struct QuestionsView: View {
    @StateObject private var viewModel = ViewModel()
    
    
    // Parameters
    @Binding var questions: Array<Question>
    
    // Properties
    @State var currentQuestionIndex: Int = 0
    @State var possibilities: Array<Answer> = []
    @State var clicked: Bool = false // State variable that determines if an option was clicked
    @State var selectionCorrect: Bool = false
    @State var displayResults: Bool = false
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if displayResults == false {
                        Text("\(questions[currentQuestionIndex].category)")
                    }
                    Spacer()
                    Text("\(currentQuestionIndex + 1) / \(questions.count)")
                }
                
                .font(.system(size: 24, weight: .bold))
                .padding()
                
                ProgressBar(percentComplete: Double(currentQuestionIndex + 1) / Double(questions.count))
                if displayResults == false {
                    triviaQuizView()
                } else {
                    resultsView()
                } // else
                
                Spacer()
            } // VStack
            .onAppear {
                possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex])
            }
        } // ZStack
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func nextClicked() {
        if selectionCorrect == true {
            viewModel.correctCount += 1
        } else {
            viewModel.incorrectCount += 1
        }
        if currentQuestionIndex + 1 >= questions.count {
            displayResults = true
            return // Do not update, causes seg fault :#
        }
        currentQuestionIndex += 1
        clicked = false
        selectionCorrect = false
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        viewModel.correctCount = 0
        viewModel.incorrectCount = 0
        displayResults = false
        clicked = false
        possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex]) // Re-initialize because on appear doesn't run from here
    }
    
    @ViewBuilder
    func triviaQuizView() -> some View {
        QuestionView(question: questions[currentQuestionIndex].question, possibilities: possibilities, clicked: $clicked, selectionCorrect: $selectionCorrect)
            .onChange(of: currentQuestionIndex) { _ in
                possibilities = viewModel.initPossiblities(question: questions[currentQuestionIndex])
            }
        if clicked {
            Button(action: {
                nextClicked()
            }) {
                Text("Next")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color.backgroundColor)
                    .frame(width: 150, height: 60)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding([.top], 30)
            } // Button
        }
    }
    
   @ViewBuilder
    func resultsView() -> some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                if Double(viewModel.correctCount) / Double(questions.count) >= 0.8 {
                    Text("Great work 🎉!\n\nYou got \(viewModel.correctCount) out of \(questions.count) questions right!")
                } else if Double(viewModel.correctCount) / Double(questions.count) >= 0.5 {
                    Text("Good job!\n\nYou got \(viewModel.correctCount) out of \(questions.count) questions right!")
                } else {
                    Text("You got \(viewModel.correctCount) out of \(questions.count) questions right.\n\nPractice makes perfect!")
                }
            } // Message VStack
            Button(action: restartGame) {
                Text("Try again!")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 200, height: 50)
                    .foregroundColor(Color.backgroundColor)
                    .background(Color.yellow)
                    .cornerRadius(12)
            } // Button
            
            Button(action: {
                self.dismiss()
            }) {
                Text("Back")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width: 200, height: 50)
                    .foregroundColor(Color.backgroundColor)
                    .background(Color.yellow)
                    .cornerRadius(12)
            } // Button
        } // VStack
        .font(.system(size: 28, weight: .medium))
        .padding([.top], 50)
    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuestionsView(questions: .constant([Question(), Question(), Question()]))
                .preferredColorScheme(.light)
        }
    }
}
