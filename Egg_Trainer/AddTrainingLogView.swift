import SwiftUI

struct AddTrainingLogView: View {
    @EnvironmentObject var store: TrainingLogStore
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var trainingDate: Date = .now
    @State private var status: TrainingStatus = .successful
    @State private var note: String = ""
    @State private var isShowingCalendar = false

    var onSave: (TrainingLog) -> Void
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var isFormValid: Bool {
        !title.isEmpty
    }

    let availableStatuses: [TrainingStatus] = [.successful, .failed]

    var body: some View {
        ZStack {
            // ✅ ИСПРАВЛЕНИЕ ЗДЕСЬ: Строка раскомментирована
            primaryBackgroundColor.ignoresSafeArea()

            VStack(spacing: 20) {
                // --- Верхняя панель ---
                HStack {
                    Button { dismiss() } label: {
                        Image("arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                    }
                    Spacer()
                    Text("Add training")
                        .font(.title2.bold())
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: saveLog) {
                        Image("ok")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                    }
                    .disabled(!isFormValid)
                }
                .padding(.horizontal)

                // --- Форма ---
                ScrollView {
                    VStack(spacing: 20) {
                        Image("one")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 140)
                            .padding(.vertical)
                        
                        CustomTextField(title: "Exercise title", placeholder: "Write here...", text: $title)
                        
                        Button(action: { isShowingCalendar = true }) {
                            CustomDatePickerView(title: "Training date", selection: $trainingDate)
                        }
                        
                        CustomPicker(title: "Type", selection: $status, options: availableStatuses)
                        
                        CustomTextField(title: "Note", placeholder: "Write here...", text: $note)
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingCalendar) {
            CalendarPickerView(selection: $trainingDate, isShowingCalendar: $isShowingCalendar)
        }
    }

    private func saveLog() {
        let newLog = TrainingLog(title: title, note: note, date: trainingDate, status: status)
        onSave(newLog)
        dismiss()
    }
}


// Вспомогательный View для Picker'а (остается без изменений)
struct CustomPicker: View {
    let title: String
    @Binding var selection: TrainingStatus
    let options: [TrainingStatus]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).bold().foregroundColor(.white).fontDesign(.rounded)
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { status in
                    Text(status.rawValue).tag(status)
                }
            }
            .pickerStyle(.menu)
            .accentColor(.white)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 5)
            .background(Color.white.opacity(0.15))
            .cornerRadius(20)
        }
    }
}
