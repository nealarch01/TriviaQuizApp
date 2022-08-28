//
//  QuestionViewModel.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import Foundation

extension QuestionsView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var correctCount: Int = 0
        @Published var incorrectCount: Int = 0
        
        public func initPossiblities(question: Question) -> Array<Answer> {
            if question.type == TriviaType.multipleChoice .rawValue{
                return initMultipleChoice(question: question)
            }
            return initTrueFalse(question: question)
        }
        
        private func initMultipleChoice(question: Question) -> Array<Answer> {
            var possibilities: Array<Answer> = []
            let correctAnswer = Answer(question.correct_answer, incorrect: false)
            possibilities.append(correctAnswer)
            for incorrectAnswer in question.incorrect_answers {
                possibilities.append(Answer(incorrectAnswer, incorrect: true))
            }
            possibilities.shuffle()
            return possibilities
        }
        
        private func initTrueFalse(question: Question) -> Array<Answer> {
            var possiblities: Array<Answer> = []
            if question.correct_answer == "True" {
                possiblities.append(Answer("True", incorrect: false))
                possiblities.append(Answer("False", incorrect: true))
            } else {
                possiblities.append(Answer("True", incorrect: true))
                possiblities.append(Answer("False", incorrect: false))
            }
            return possiblities
        }
    }
}
