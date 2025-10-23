import SwiftUI
import PhotosUI

struct AddNoteView: View {

    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var noteText: String = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var isShowingCalendar = false

    @Environment(\.dismiss) var dismiss
    
    var onSave: (PersonalNote) -> Void
    
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var body: some View {
        ZStack {
            Image(.background)
                .resizeAnd()
            // Весь контент теперь внутри ZStack, к которому мы применим фон
            VStack(spacing: 20) {
                // --- Верхняя панель ---
                HStack {
                    Button { dismiss() } label: { Image("arrow").resizable().scaledToFit().frame(width: 28, height: 28) }
                    Spacer()
                    Text("Add note").font(.title2.bold()).fontDesign(.rounded).foregroundColor(.white)
                    Spacer()
                    Button(action: saveNote) { Image("ok").renderingMode(.original).resizable().scaledToFit().frame(width: 28, height: 28) }
                }
                .padding(.horizontal)

                // --- Форма для ввода данных ---
                ScrollView {
                    VStack(spacing: 20) {
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.15))
                                    .aspectRatio(1.0, contentMode: .fit)

                                if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        .frame(width: 200)
                        .onChange(of: selectedPhoto) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            CustomTextField(title: "Title", placeholder: "Write here..", text: $title)
                            Button(action: { isShowingCalendar = true }) {
                                CustomDatePickerView(title: "Date", selection: $date)
                            }
                            CustomTextField(title: "Note", placeholder: "Write here..", text: $noteText)
                        }
                        .padding(.horizontal, 40)
                    }
                    .padding()
                }
            }
        }
        // ✅ ИСПРАВЛЕНИЕ ЗДЕСЬ: Устанавливаем фон для всего ZStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingCalendar) {
            CalendarPickerView(selection: $date, isShowingCalendar: $isShowingCalendar)
        }
    }
    
    func saveNote() {
        let newNote = PersonalNote(
            title: title,
            noteText: noteText,
            date: date,
            imageData: selectedImageData
        )
        onSave(newNote)
        dismiss()
    }
}
