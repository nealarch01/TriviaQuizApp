//
//  Question.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/25/22.
//

import Foundation

enum Difficulty: String {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    case any = "any"
}

enum TriviaType: String {
    case multipleChoice = "multiple"
    case trueFalse = "boolean"
    case both = ""
}

class Question: Decodable {
    private(set) var `category`: String
    private(set) var `type`: String
    private(set) var difficulty: String
    private(set) var question: String
    private(set) var correct_answer: String
    private(set) var incorrect_answers: Array<String>
    
    init() {
        self.category = "Geography"
        self.type = "multiple"
        self.difficulty = "medium"
        self.question = "Which country inside the United Kingdom does NOT appear on its flag, the Union Jack?"
        self.correct_answer = "Wales"
        self.incorrect_answers = ["Scotland", "Ireland", "Isle of Wight"]
    }
    
    public func decodeBase64Strings() {
        if let decodedCategory = decodeBase64(string: self.category) {
            self.category = decodedCategory
        }
        
        if let decodedType = decodeBase64(string: self.type) {
            self.type = decodedType
        }
        
        if let decodedDifficulty = decodeBase64(string: self.difficulty) {
            self.difficulty = decodedDifficulty
        }
        
        if let decodedQuestion = decodeBase64(string: self.question) {
            self.question = decodedQuestion
        }
        
        if let decodedCorrectAnswer = decodeBase64(string: self.correct_answer) {
            self.correct_answer = decodedCorrectAnswer
        }
        
        for i in 0..<self.incorrect_answers.count {
            if let decodedIncorrectAnswer = decodeBase64(string: self.incorrect_answers[i]) {
                self.incorrect_answers[i] = decodedIncorrectAnswer
            }
        }
    }
    
    public func printProperties() {
        print("Category: \(self.category)")
        print("Type: \(self.type)")
        print("Difficulty: \(self.difficulty)")
        print("Question: \(self.question)")
        print("Correct Answer: \(self.correct_answer)")
        print("Incorrect answers: \(self.incorrect_answers)")
    }
    
    private func decodeBase64(string: String) -> String? {
        if let stringData = Data(base64Encoded: string) { // First convert string to Base64 Encoded Data
            if let decodedString = String(data: stringData, encoding: .utf8) { // Then, decode string
                return decodedString // If neither return nil, return the new string
            }
        }
        // If the string isn't in Base64 format, return nil and do not update
        return nil
    }
}

class QuestionsDecodable: Decodable {
    private(set) var response_code: Int
    private(set) var results: Array<Question>
    
    init() {
        /*
         Taken from documentation:
         
         Code 0: Success Returned results successfully.
         Code 1: No Results Could not return results. The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)
         Code 2: Invalid Parameter Contains an invalid parameter. Arguements passed in aren't valid. (Ex. Amount = Five)
         Code 3: Token Not Found Session Token does not exist.
         Code 4: Token Empty Session Token has returned all possible questions for the specified query. Resetting the Token is necessary.
        */
        self.response_code = 0
        self.results = [Question()]
    }
}
