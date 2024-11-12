import SwiftUI

struct ContentView: View {
    var platform: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                                .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
                                .init(name: "PC", imageName: "pc", color: .pink),
                                .init(name: "Mobile", imageName: "iphone", color: .mint)]
    
    var games: [Game] = [.init(name: "COD", rating: 99),
                        .init(name: "God Of War", rating: 90),
                        .init(name: "Plague", rating: 98),
                        .init(name: "SR4", rating: 99)]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        ZStack {
            // Set the entire background color here
            Color.blue
                .ignoresSafeArea() // Ensures the background color covers the entire screen
            
            NavigationStack(path: $path) {
                List {
                    Section("Platforms") {
                        ForEach(platform, id: \.name) { platform in
                            NavigationLink(value: platform) {
                                Label(platform.name, systemImage: platform.imageName)
                                    .foregroundStyle(platform.color)
                            }
                        }
                    }
                    Section("Games") {
                        ForEach(games, id: \.name) { game in
                            NavigationLink(value: game) {
                                Text(game.name)
                                    .foregroundStyle(Color.gray)
                            }
                        }
                    }
                }
                .navigationTitle("GAMING")
                .background(Color.clear) // Ensures the List doesn't override the background
                .navigationDestination(for: Platform.self) { platform in
                    ZStack {
                        platform.color.ignoresSafeArea()
                        VStack {
                            Label(platform.name, systemImage: platform.imageName)
                                .font(.largeTitle).bold()
                            List {
                                ForEach(games, id: \.name) { game in
                                    NavigationLink(value: game) {
                                        Text(game.name)
                                            .foregroundStyle(Color.gray)
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationDestination(for: Game.self) { game in
                    VStack(spacing: 20) {
                        Text("\(game.name) - \(game.rating)")
                            .font(.largeTitle.bold().italic())
                        
                        Button("Recommended game") {
                            if let randomGame = games.randomElement() {
                                path.append(randomGame)
                            }
                        }
                        
                        Button("Go to another platform") {
                            if let randomPlatform = platform.randomElement() {
                                path.append(randomPlatform)
                            }
                        }
                        
                        Button("Go Home") {
                            path.removeLast(path.count)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: Int
}
