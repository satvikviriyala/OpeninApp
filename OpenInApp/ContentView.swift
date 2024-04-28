import SwiftUI

struct ContentView: View {
    @State private var showAllLinks = false // State for link display

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                //I have Divided app into Sections for Better Organization
                // Header and Greetings section
                HeaderSection()

                // to overview the graphs which will  be added soon
                OverviewSection()

                // Top Links and Recent Links
                LinksSection(showAllLinks: $showAllLinks) //we have Pass state as binding

                // Support Options(eg: talk with us and frequently used questions)
                SupportOptionsSection()

                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .overlay(alignment: .bottom) {
            BottomNavigationView()
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}


// code of sections start here

struct HeaderSection: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Dashboard")
                    .font(.title2).bold()
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "gear")
                    .foregroundColor(.white)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.05, green: 0.44, blue: 1)
                .cornerRadius(20))
            .ignoresSafeArea(.all, edges: .top)

            VStack(alignment: .leading, spacing: 5) {
                Text("Good morning")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(alignment: .bottom, spacing: 8) { // Align to bottom
                    Text("Ajay Manva")
                        .font(.title2).bold()
                    Image(systemName: "hand.wave")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 10)
        }
    }
}
struct OverviewSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Overview")
                .font(.headline)
                .foregroundColor(.gray)
            
            // Graph Goes here
            ZStack {
                // We have to implement our graph over here which we get through API calls
                Text("Graph Placeholder")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 150)
            .background(Color.white)
            .cornerRadius(8)
            
            HStack {
                Text("22 Aug - 23 Sept")
                Image(systemName: "arrow.clockwise")
            }
            
            ScrollView(.horizontal, showsIndicators: false) { // Adding a horizontal ScrollView
                HStack(spacing: 20) { // Increasing spacing between cards for better visibility
                    OverviewCardView(imageName: "person.crop.circle.badge.questionmark", value: "123", title: "Today's clicks")
                    OverviewCardView(imageName: "location", value: "Ahamedab..", title: "Top Location")
                    OverviewCardView(imageName: "camera", value: "Instagram", title: "Top source")
                }
                .padding(.horizontal)
            }
            
            Button("View Analytics") {
                // action can be implemented in future
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}

struct OverviewCardView: View {
    let imageName: String
    let value: String
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: imageName)
                .font(.title2)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text(value)
                    .font(.headline).bold()
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
    }
}


struct LinksSection: View {
    @Binding var showAllLinks: Bool
    
    let sampleLinks = Array(1...10).map {
        LinkItem(imageName: "a.circle.fill", title: "Sample link name \($0)", url: "https://samplelink.oia.bio/ashd...", clicks: "2323")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Top Links")
                    .font(.headline).bold()
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(red: 0.05, green: 0.44, blue: 1))
                    .cornerRadius(20)
                
                Text("Recent Links")
                    .font(.headline).bold()
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            
            ForEach(showAllLinks ? sampleLinks : Array(sampleLinks.prefix(5))) { link in
                LinkItemView(link: link)
            }
            
            Button(showAllLinks ? "View Less Links" : "View all Links") { // Toggle button text
                        showAllLinks.toggle()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
        }
    }
}

struct LinkItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let url: String
    let clicks: String
}

struct LinkItemView: View {
    let link: LinkItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: link.imageName)
                Text(link.title)
                Spacer()
                Text(link.clicks)
                    .foregroundColor(.gray)
            }
            
            Text(link.url)
                .font(.caption)
                .foregroundColor(Color(red: 0.05, green: 0.44, blue: 1))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color(red: 0.05, green: 0.44, blue: 1).opacity(0.12))
                .cornerRadius(4)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
};struct SupportOptionsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "bubble.left")
                Text("Talk with us")
                    .font(.headline).bold()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.12))
            .cornerRadius(8)
            
            HStack {
                Image(systemName: "questionmark.circle")
                Text("Frequently Asked Questions")
                    .font(.headline).bold()
                Spacer()
            }
            
            .padding()
            .background(Color.blue.opacity(0.12))
            .cornerRadius(8)
            Spacer(minLength: 60)
        }
    }
}


struct BottomNavigationView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                // Navigations will be implemented over here
                Image(systemName: "link")
                Spacer()
                Image(systemName: "book.closed")
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(red: 0.05, green: 0.44, blue: 1))
                        .frame(width: 60, height: 60)
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                }
                Spacer()
                Image(systemName: "speaker.wave.2")
                Spacer()
                Image(systemName: "person")
            }
            .font(.headline)
            .padding(.horizontal)
            .padding(.top, 15)
            .padding(.bottom, 30)
            .background(Color.white)
        .cornerRadius(30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
