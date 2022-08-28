//
//  ContentViewModel.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/25/22.
//

import Foundation

extension ContentView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var selectedCategory: String
        @Published var categories: Array<TriviaCategory>
        @Published var errorMessage: String = ""
        
        @Published var triviaOptionsActive: Bool = false // False by default
        @Published var rootActive: Bool = true // True by default
        
        init() {
            selectedCategory = ""
            categories = []
        }
        
        public func setupCategories() async -> Void {
            if categories.count != 0 {
                return // We have already initialized categories, no need to re-run
            }
            let serviceResponse = await TriviaService().fetchCategories()
            if serviceResponse.error != nil {
                errorMessage = serviceResponse.error!
                return
            }
            
            if serviceResponse.error != nil {
                self.errorMessage = serviceResponse.error!
            }
            categories = serviceResponse.categories
        }
        
        public func formatCategoryName(name: String) -> String {
            let formatted: String = name.replacingOccurrences(of: "Entertainment: ", with: "")
            return formatted
        }
        
    }
}
