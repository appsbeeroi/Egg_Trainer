import SwiftUI


struct CustomTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).bold().foregroundColor(.white).fontDesign(.rounded)
            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.5)))
                .padding()
                .background(Color.white.opacity(0.15))
                .cornerRadius(20)
                .foregroundColor(.white)
                .fontDesign(.rounded)
        }
    }
}

struct CustomDatePickerView: View {
    let title: String
    @Binding var selection: Date
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: selection)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).bold().foregroundColor(.white).fontDesign(.rounded)
            HStack {
                Text(formattedDate)
                    .foregroundColor(.white)
                    .fontDesign(.rounded)
                Spacer()
                Image("calendar")
            }
            .padding()
            .background(Color.white.opacity(0.15))
            .cornerRadius(20)
        }
    }
}

struct CalendarPickerView: View {
    @Binding var selection: Date
    @Binding var isShowingCalendar: Bool
    
    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selection, displayedComponents: .date)
                .datePickerStyle(.graphical)
   
                .colorScheme(.light)
            
            Button("Done") { isShowingCalendar = false }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.orange) 
        }
        .padding()

        .background(Color(.systemBackground).ignoresSafeArea())
    }
}
