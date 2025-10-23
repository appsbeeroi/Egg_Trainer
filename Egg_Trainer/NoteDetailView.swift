import SwiftUI

struct NoteDetailView: View {
    @Binding var note: PersonalNote
    var onDelete: () -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var isShowingEditView = false
    
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizeAnd()
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image("arrow")
                            .resizable().scaledToFit().frame(width: 28)
                    }
                    Spacer()
                    Button(action: { isShowingEditView = true }) {
                        Image("edit")
                            .resizable().scaledToFit().frame(width: 28)
                    }
                    Button(action: {
                        onDelete()
                        dismiss()
                    }) {
                        Image("delete")
                            .resizable().scaledToFit().frame(width: 28)
                    }
                }
                .padding(.horizontal)

                // --- Контент ---
                ScrollView {
                    VStack(spacing: 20) {
                        // --- Главная картинка ---
                        if let image = note.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        Text(note.title)
                            .font(.largeTitle.bold())
                            .fontDesign(.rounded)
                            .foregroundColor(.white)
                        
                        HStack {
                            Image("calendar")
                                .resizable().scaledToFit().frame(height: 20)
                            Text(note.dateString)
                                .font(.headline)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Note")
                                .font(.headline).fontWeight(.bold).fontDesign(.rounded)
                                .foregroundColor(.white.opacity(0.8))
                            Text(note.noteText)
                                .fontWeight(.bold).fontDesign(.rounded)
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                    }
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingEditView) {
            // EditNoteView(note: $note)
        }
    }
}
