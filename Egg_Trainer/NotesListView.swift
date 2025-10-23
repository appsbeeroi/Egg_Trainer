import SwiftUI

struct NotesListView: View {
    @State private var notes: [PersonalNote] = [
        PersonalNote(title: "Method with treats", noteText: "Today I tried...", date: Date(), imageData: UIImage(named: "chicken_placeholder")?.pngData())
    ]
    @State private var isShowingAddView = false
    
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.background)
                    .resizeAnd()
                
                
                VStack(spacing: 15) {
                    Text("Personal notes")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top)

                    if notes.isEmpty {
                        EmptyStateView2(isShowingAddView: $isShowingAddView)
                    } else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach($notes) { $note in
                                    NavigationLink(value: note) {
                                        NoteRowView(note: note)
                                    }
                                }
                                
                             Button(action: { isShowingAddView = true }) {
                                    Text("Add note")
                                        .font(.title3.bold())
                                        .fontDesign(.rounded)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.orange)
                                        .cornerRadius(25)
                                }
                                .padding(.top)
                            }
                            .padding([.horizontal, .bottom])
                        }
                        .padding(.bottom, 90)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddNoteView(onSave: addNote)
            }
            .navigationDestination(for: PersonalNote.self) { note in
                if let index = notes.firstIndex(where: { $0.id == note.id }) {
                     NoteDetailView(note: $notes[index], onDelete: { deleteNote(noteToDelete: note) })
                }
            }
        }
    }

    func addNote(_ note: PersonalNote) {
        notes.append(note)
    }
    
    func deleteNote(noteToDelete: PersonalNote) {
        notes.removeAll { $0.id == noteToDelete.id }
    }
}




struct EmptyStateView2: View {
    @Binding var isShowingAddView: Bool

    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            Image("two")
                .resizable().scaledToFit().frame(width: 250)
            Text("Here will be your personal notes.\nStart with the first idea!")
                .font(.title3.bold()).fontDesign(.rounded).multilineTextAlignment(.center).foregroundColor(.white)
            Spacer()
            
            Button(action: { isShowingAddView = true }) {
                Text("Add note")
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


struct NoteRowView: View {
    let note: PersonalNote
    var body: some View {
        HStack(spacing: 15) {
            if let image = note.image {
                Image(uiImage: image)
                    .resizable().aspectRatio(contentMode: .fill).frame(width: 60, height: 60).clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                RoundedRectangle(cornerRadius: 12).fill(Color.black.opacity(0.2)).frame(width: 60, height: 60)
                    .overlay(Image(systemName: "photo.on.rectangle").foregroundColor(.white.opacity(0.5)).font(.largeTitle))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(note.title).font(.headline).fontWeight(.bold).fontDesign(.rounded).foregroundColor(.white)
                HStack {
                    Image("calendar").resizable().scaledToFit().frame(height: 20)
                    Text(note.dateString).font(.subheadline).fontWeight(.bold).fontDesign(.rounded).foregroundColor(.white.opacity(0.8))
                }
            }
            Spacer()
        }
        .padding().background(Color.white.opacity(0.15)).cornerRadius(20)
    }
}
