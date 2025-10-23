import SwiftUI

struct TrainingLogListView: View {
    @EnvironmentObject var store: TrainingLogStore
    
    @State private var isShowingAddView = false
    
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.background)
                    .resizeAnd()
                
                VStack(spacing: 15) {
                    Text("Training record")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top)

                    if store.logs.isEmpty {
                        EmptyStateView(isShowingAddView: $isShowingAddView)
                    } else {
                        // ✅ ИЗМЕНЕНИЕ: List заменен на ScrollView для гибкости
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach($store.logs) { $log in
                                    NavigationLink(value: log) {
                                        TrainingLogListRow(log: log)
                                    }
                                }
                                .onDelete(perform: deleteLog)
                                
                                // ✅ ИЗМЕНЕНИЕ: Оранжевая кнопка добавлена сюда
                                Button(action: { isShowingAddView = true }) {
                                    Text("Add training")
                                        .font(.title3.bold())
                                        .fontDesign(.rounded)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.orange)
                                        .cornerRadius(25)
                                }
                                .padding(.top) // Отступ сверху для кнопки
                            }
                            .padding([.horizontal, .bottom])
                        }
                        .padding(.bottom, 90)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddTrainingLogView(onSave: { newLog in
                    store.addLog(newLog)
                })
                .environmentObject(store)
            }
            .navigationDestination(for: TrainingLog.self) { log in
                if let index = store.logs.firstIndex(where: { $0.id == log.id }) {
                    TrainingLogDetailView(log: $store.logs[index])
                }
            }
        }
    }
    
    private func deleteLog(at offsets: IndexSet) {
        let logsToDelete = offsets.map { store.logs[$0] }
        for log in logsToDelete {
            store.deleteLog(logToDelete: log)
        }
    }
}


// Вспомогательные View (остаются без изменений)
struct EmptyStateView: View {
    @Binding var isShowingAddView: Bool
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            Image("one")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Text("Here will be your exercises.\nAdd the first!")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: { isShowingAddView = true }) {
                Text("Add training")
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(25)
            }
        }
        .padding()
    }
}

struct TrainingLogListRow: View {
    let log: TrainingLog
    
    var body: some View {
        HStack(spacing: 15) {
            Image("one")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(log.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                
                HStack {
                    Image("calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                    
                    Text(log.dateString)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
    }
}
