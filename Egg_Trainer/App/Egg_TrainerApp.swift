import SwiftUI

@main
struct Egg_TrainerApp: App {

    @StateObject private var store = TrainingLogStore()
    
    @State private var isShowingSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isShowingSplash {
                   SplashScreenView()
                        .transition(.opacity)
                        .onAppear {
                           
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation {
                                    isShowingSplash = false
                                }
                            }
                        }
                } else {
                    ContentView()
                        .environmentObject(store)
                }
            }
        }
    }
}
