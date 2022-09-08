//
//  TriviaService.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import Foundation

class TriviaService {
    public func fetchTriviaQuestions(difficulty: Difficulty, category: TriviaCategory, triviaType: TriviaType, quantity: Int) async -> (questions: Array<Question>, error: String?) {
        // Sample https://opentdb.com/api.php?amount=10&category=10&difficulty=medium&type=multiple
        var urlString: String = "https://opentdb.com/api.php?amount=\(quantity)&category=\(category.id)"
        if difficulty != Difficulty.any {
            urlString += "&difficulty=\(difficulty.rawValue)"
        }
        
        if triviaType != TriviaType.both {
            urlString += "&type=\(triviaType.rawValue)"
        }
        
        urlString += "&encode=base64"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (dataResponse, urlResponse) = try await URLSession.shared.data(for: request)
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                return ([], "Server response error.")
            }
            
            if httpUrlResponse.statusCode != 200 {
                return ([], "Error: \(httpUrlResponse.statusCode)")
            }
            
            guard let decodedData = try? JSONDecoder().decode(QuestionsDecodable.self, from: dataResponse) else {
                return ([], "An error occured obtaining trivia questions. Try again")
            }
            
            if decodedData.response_code == 1 {
                return ([], "Not enough questions in database 😕")
            } else if decodedData.response_code != 0 {
                return ([], "There was an error initializing game 😕")
            }
            
            print("Successfully fetched trivia questions!")
            
            for question in decodedData.results {
                question.decodeBase64Strings()
            }
            
            return (decodedData.results, nil) // Successful
            
        } catch let error {
            print(error.localizedDescription)
            return ([], error.localizedDescription)
        }
    }
    
    
    
    
    
    public func fetchCategories() async -> (categories: Array<TriviaCategory>, error: String?) {
        let apiURL = URL(string: "https://opentdb.com/api_category.php")!
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (dataResponse, urlResponse) = try await URLSession.shared.data(for: request) // URLResponse is not needed since a status code is provided by the API
            guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                return ([], "Server response error.")
            }
            
            if httpUrlResponse.statusCode != 200 {
                return ([], "Error: \(httpUrlResponse.statusCode)")
            }
            
            guard let decodedData = try? JSONDecoder().decode(TriviaCategories.self, from: dataResponse) else {
                // Handle nil case
                print("Decode error")
                return ([], "An error occured obtaining categories. Try again")
            }
            
            print("Successfully fetched category data!")
            
            return (decodedData.trivia_categories, nil)
            
        } catch let error {
            print(error.localizedDescription)
            return ([], error.localizedDescription)
        }
    }
}

