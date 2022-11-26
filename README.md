# Trivia Quiz iOS App
iOS Trivia app that uses OpenTriviaDatabase API
- Implemented in SwiftUI
- MVVM Architecture
- API Fetching and JSON decoding
- Light and Dark Mode UI
- Relative Component Sizing / Positioning
- Responsive User Interface for iPhones

Project Structure
```
./iOSTrivia
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   └── Contents.json
│   ├── BackgroundColor.colorset
│   │   └── Contents.json
│   ├── Contents.json
│   └── ContrastColor.colorset
│       └── Contents.json
├── Components
│   ├── OptionButton.swift
│   └── ProgressBar.swift
├── Extensions
│   └── Extensions.swift
├── Models
│   ├── Answer.swift
│   ├── Category.swift
│   └── Question.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       └── Contents.json
├── Services
│   └── TriviaService.swift
├── ViewModels
│   ├── ContentViewModel.swift
│   ├── QuestionsViewModel.swift
│   └── TriviaOptionsViewModel.swift
├── Views
│   ├── ContentView.swift
│   ├── QuestionsView.swift
│   └── TriviaOptionsView.swift
└── iOSTriviaApp.swift
```


## Video
https://user-images.githubusercontent.com/73256760/187053981-667881ad-fe56-4f41-a5b4-4b9689563ffb.mov



## Attributions: 
Trivia questions and category obtained from https://opentdb.com
