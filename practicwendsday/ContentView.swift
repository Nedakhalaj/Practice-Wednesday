//
//  ContentView.swift
//  practicwendsday
//
//  Created by neda khalajnejad on 2026-03-25.
//

import SwiftUI

struct RecepiBook: Identifiable{
    let id = UUID()
    let title : String
    let ingredient : [String]
    let difficulty : String
    let instruction : String
    let time : Int
}

struct ContentView: View {
    @State var myBooks = [
        RecepiBook(title: "Pannkakor", ingredient: ["Oil","flour","sugar"],  difficulty: "easy",
                   instruction: "mixed flour and sugar, heat oil, pour in batter, cook on griddle",
                   time: 15),
        RecepiBook( title: "Lasagne", ingredient: ["meat","spices"], difficulty: "medium", instruction: "cookes layer by layer",
                    time: 60),
        RecepiBook( title: "Tacos",
                    ingredient: [], difficulty: "hard", instruction: "fried meat with veggies", time: 20),
        RecepiBook( title: "Sushibowls ", ingredient: ["fish", "rice"], difficulty: "mrdium", instruction: "raw fish with rice", time: 30)
    ]
    
    var body: some View {
        NavigationStack{
            List(myBooks){ book in
            
                NavigationLink{
                    Text("test")
                }label: {
                    VStack{
                        Text(book.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                        Text("\(book.time)")
                        HStack{
                            Text("\(book.difficulty.capitalized)")
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
