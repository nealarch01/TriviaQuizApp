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
## Screenshots
<img width="381" alt="Screenshot 2023-02-06 at 5 24 38 PM" src="https://user-images.githubusercontent.com/73256760/217124484-2d7f1c87-b6f3-4b5f-8d85-cb33e111423b.png">
<img width="365" alt="Screenshot 2023-02-06 at 5 24 46 PM" src="https://user-images.githubusercontent.com/73256760/217124516-3cf0ceee-40ca-4450-b3f0-87634fda151e.png">


## Video
https://user-images.githubusercontent.com/73256760/187053981-667881ad-fe56-4f41-a5b4-4b9689563ffb.mov



## Attributions: 
Trivia questions and category obtained from https://opentdb.com
