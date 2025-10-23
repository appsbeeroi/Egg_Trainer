import SwiftUI

// --- VIEW ДЛЯ ЗНАЧКА ---
struct ResultBadgeView: View {
    let status: TrainingStatus

    var body: some View {
        HStack(spacing: 8) {
            Image(status == .failed ? "fail" : "ok")
                .resizable()
                .scaledToFit()
                .frame(height: 24) 

            Text(status.rawValue)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .fontDesign(.rounded)
        .padding(.horizontal, 14)
        .padding(.vertical, 7)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}


struct TrainingLogDetailView: View {
    @EnvironmentObject var store: TrainingLogStore
    @Environment(\.dismiss) var dismiss
    
    @Binding var log: TrainingLog
    @State private var isShowingEditView = false

    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizeAnd()
            
            VStack(spacing: 20) {
                // --- Верхняя панель ---
                HStack {
                    Button(action: { dismiss() }) {
                        Image("arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                    }
                    Spacer()
                    Button(action: { isShowingEditView = true }) {
                        Image("edit")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                    }
                    Button(action: {
                        store.deleteLog(logToDelete: log)
                        dismiss()
                    }) {
                        Image("delete")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                    }
                }

                if log.status != .inProgress {
                    ResultBadgeView(status: log.status)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                
                Image("one").resizable().scaledToFit().frame(height: 140).padding(.bottom)
                
                Text(log.title)
                    .font(.largeTitle.bold())
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                
                HStack(spacing: 8) {
                    Image("calendar")
                    Text(log.dateString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.headline)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.white)
                }
                
                if !log.note.isEmpty {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Note")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(log.note)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingEditView) {
            EditTrainingLogView(log: $log)
                .environmentObject(store)
        }
    }
}

// --- View для редактирования записи ---
struct EditTrainingLogView: View {
    @EnvironmentObject var store: TrainingLogStore
    @Environment(\.dismiss) var dismiss
    
    @Binding var log: TrainingLog
    @State private var draftLog: TrainingLog

    init(log: Binding<TrainingLog>) {
        self._log = log
        self._draftLog = State(initialValue: log.wrappedValue)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    TextField("Title", text: $draftLog.title)
                    TextField("Note", text: $draftLog.note, axis: .vertical)
                }
            }
            .fontDesign(.rounded)
            .navigationTitle("Edit Training")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.updateLog(updatedLog: draftLog)
                        log = draftLog
                        dismiss()
                    }
                }
            }
        }
    }
}
