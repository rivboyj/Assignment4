//
// ContentView.swift
// YourAppname
//
// Created by River on 9/21/23.
//

import SwiftUI

// Define the CatBreed struct
struct CatBreed: Codable, Identifiable {
    var id: String
    var name: String 
    var description: String
    var origin: String
    var temperament: String
    var life_span: String
    var indoor: Int
    
    // Add other properties you need
}

// Define the ContentView
struct ContentView: View {
    @State private var catBreeds: [CatBreed] = []

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination:ExtraDetailes()) {
                    Text("More cat details")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button("Get Cat Breeds") {
                    fetchCatBreeds { breeds in
                        if let breeds = breeds {
                            catBreeds = breeds
                        }
                    }
                }

                List(catBreeds) { breed in
                    CatView(cat: breed)
                }
            }
        }
    }
}

struct ExtraDetailes: View {
    var body: some View {
        Text("ID: abys")
        Text("Name: Abyssinian")
        Text("Life Span: 14 - 15")
        Text("Indoor: 0")
        Text("Lap: 1")
        Text("Alt Names: (empty)")
        Text("Adaptability: 5")
        Text("Affection Level: 5")
        Text("Child Friendly: 3")
        Text("Suppressed Tail: 0")
            .navigationBarTitle("Abys", displayMode: .inline)
    }
}


// Define the CatView
struct CatView: View {
    var cat: CatBreed

    var body: some View {
        VStack {
            Text("Name: \(cat.name)")
            Text("Description: \(cat.description)")
            Text("Origin: \(cat.origin)")
            // Add more Text views for other properties
        }
    }
}

// Function to fetch cat breeds from the API
func fetchCatBreeds(completion: @escaping ([CatBreed]?) -> Void) {
    if let url = URL(string: "https://api.thecatapi.com/v1/breeds") {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let catBreeds = try JSONDecoder().decode([CatBreed].self, from: data)
                    completion(catBreeds)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    completion(nil)
                }
            } else if let error = error {
                print("API Request Error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    } else {
        completion(nil)
    }
}

// Preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
