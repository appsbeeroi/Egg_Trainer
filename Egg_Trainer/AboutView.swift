import SwiftUI

struct AboutView: View {
    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var body: some View {
        ZStack {
            primaryBackgroundColor.ignoresSafeArea()

            VStack {
                Text("We Stand with Ukraine, Developers")
                    .foregroundColor(.white)
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(20)
                    .padding()

                Spacer()
            }
        }
        .navigationTitle("About the app")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AboutView()
        }
    }
}
