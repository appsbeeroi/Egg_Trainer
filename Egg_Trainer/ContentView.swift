import SwiftUI

enum Tab {
    case program, training, note, settings
}

struct ContentView: View {
    @State private var selectedTab: Tab = .training
    
    var body: some View {
        ZStack {
            switch selectedTab {
                case .program:
                    TrainingProgramListView()
                case .training:
                    TrainingLogListView()
                case .note:
                    NotesListView()
                case .settings:
                    SettingsView()
            }
            
            VStack {
                HStack {
                    CustomTabButton(tab: .program, selectedTab: $selectedTab, unselectedImage: "pro1", selectedImage: "pro2")
                    CustomTabButton(tab: .training, selectedTab: $selectedTab, unselectedImage: "tra1", selectedImage: "tra2")
                    CustomTabButton(tab: .note, selectedTab: $selectedTab, unselectedImage: "not1", selectedImage: "not2")
                    CustomTabButton(tab: .settings, selectedTab: $selectedTab, unselectedImage: "set1", selectedImage: "set2")
                }
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .background(.white.opacity(0.25))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}


struct CustomTabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    let unselectedImage: String
    let selectedImage: String

    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = tab
            }
        }) {
            Image(selectedTab == tab ? selectedImage : unselectedImage)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .frame(maxWidth: .infinity)
    }
}

extension Image {
    func resizeAnd() -> some View {
        GeometryReader { geo in
        self
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}
