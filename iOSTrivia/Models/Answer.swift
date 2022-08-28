//
//  Answer.swift
//  iOSTrivia
//
//  Created by Neal Archival on 8/26/22.
//

import Foundation

class Answer: Identifiable {
    private(set) var uuid: UUID
    private(set) var text: String
    private(set) var incorrect: Bool
    
    init() {
        self.uuid = UUID()
        self.text = "Text"
        self.incorrect = true
    }
    
    init(_ text: String, incorrect: Bool) {
        self.uuid = UUID()
        self.text = text
        self.incorrect = incorrect
    }
}
