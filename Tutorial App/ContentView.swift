import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                MapView()
                    .frame(height: 300)
                CircleImage()
                    .offset(y: -130)
                    .padding(.bottom, -130)
                VStack(alignment: .leading) {
                    Text("Turtle Rock")
                        .font(.title)
                        .foregroundColor(.primary)
                    HStack {
                        Text("Joshua Tree National Park")
                        Spacer()
                        Text("California")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    Divider()
                    Text("About Turtle Rock")
                        .font(.title2)
                    Text("Descriptive text goes here.")
                    Button(action: {
                        // Add favorite action
                    }) {
                        Text("Add to Favorites")
                    }
                    .padding(.top, 8)
                }
                .padding()
                Spacer()
                
                NavigationLink("View Resume") {
                    ResumeView()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
