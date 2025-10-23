import SwiftUI
import UserNotifications

struct SettingsView: View {

    @State private var notificationsEnabled = false
    @State private var showingClearHistoryAlert = false
    
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.background)
                    .resizeAnd()
                
                VStack(spacing: 30) {
                    Spacer().frame(height: 20)
                    Image("tree")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.7))
                    
                    VStack(spacing: 15) {
                        Toggle(isOn: $notificationsEnabled) {
                            Text("Notification")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                        .tint(.orange) // Цвет переключателя
                        .onChange(of: notificationsEnabled) { value in
                            handleNotifications(enabled: value)
                        }

                        NavigationLink(destination: AboutView()) {
                            HStack {
                                Text("About the app")
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                        
                        HStack {
                            Text("History")
                                .foregroundColor(.white)
                            Spacer()
                            Button("Clear") {
                                showingClearHistoryAlert = true
                            }
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                //.navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                         VStack {
                            Text("Settings")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            Spacer()
                         }
                    }
                }
            }
            .alert("Clear history", isPresented: $showingClearHistoryAlert) {
                Button("Delete", role: .destructive) {
                    print("History cleared.")
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to delete the entire history? This action cannot be undone.")
            }
        }
    }
    
    func handleNotifications(enabled: Bool) {
        if enabled {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    print("Permissions granted.")
                } else {

                    DispatchQueue.main.async {
                        notificationsEnabled = false
                    }
                }
            }
        } else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            print("Notifications cancelled.")
        }
    }
}
