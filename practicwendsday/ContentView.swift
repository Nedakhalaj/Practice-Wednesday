//
//  ContentView.swift
//  practicwendsday
//
//  Created by neda khalajnejad on 2026-03-25.
//

import SwiftUI

struct RecepiBook: Identifiable {
    let id = UUID()
    let title: String
    let ingredient: [String]
    let difficulty: String
    let instruction: String
    let time: Int
}

struct ContentView: View {
    @State var myBooks = [
        RecepiBook(
            title: "Pannkakor",
            ingredient: ["Oil", "flour", "sugar"],
            difficulty: "easy",
            instruction:
                "mixed flour and sugar, heat oil, pour in batter, cook on griddle",
            time: 15
        ),
        RecepiBook(
            title: "Lasagne",
            ingredient: ["meat", "spices"],
            difficulty: "medium",
            instruction: "cookes layer by layer",
            time: 60
        ),
        RecepiBook(
            title: "Tacos",
            ingredient: [],
            difficulty: "hard",
            instruction: "fried meat with veggies",
            time: 20
        ),
        RecepiBook(
            title: "Sushibowls ",
            ingredient: ["fish", "rice"],
            difficulty: "mrdium",
            instruction: "raw fish with rice",
            time: 30
        ),
    ]

    @State var newTitle: String = ""
    @State var newIngredient: [String] = [""]
    @State var ingredientInput: String = ""
    @State var newDifficulty: String = ""
    @State var newInstruction: String = ""
    @State var newTime: Int = 0
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(myBooks) { book in
                    NavigationLink {
                        DetailView(Recipe: book)
                    } label: {
                        VStack {
                            Text(book.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding()
                            Text("\(book.time)")
                            HStack {
                                Text("\(book.difficulty.capitalized)")
                                Spacer()
                            }
                        }
                    }
                }.onDelete { IndexSet in
                    myBooks.remove(atOffsets: IndexSet)
                }
            }

            TextField("Recipe Name", text: $newTitle)
            TextField("Ingredients", text: $ingredientInput)
            Button("Add ingredient") {
                newIngredient.append(ingredientInput)
                ingredientInput = ""
            }
            TextField("Recipe Difficulty", text: $newDifficulty)
            TextField("Instructions", text: $newInstruction)
            TextField("Cooking time", value: $newTime, format: .number)

            Button("Add Recepi") {
                myBooks.append(
                    RecepiBook(
                        title: newTitle,
                        ingredient: newIngredient,
                        difficulty: newDifficulty,
                        instruction: newInstruction,
                        time: newTime
                    )
                )
                newTitle = ""
                newDifficulty = ""
                newInstruction = ""
                newTime = 0
            }
        }
    }
}
struct DetailView: View {
    let Recipe: RecepiBook
    var body: some View {
        VStack {
            Text(Recipe.title)
            HStack {
                Text("Igreedients:")
                if Recipe.ingredient.count > 1 {
                    ForEach(0..<Recipe.ingredient.count) { value in
                        Text(Recipe.ingredient[value])
                    }
                }
            }
            Text(Recipe.instruction)
        }
    }
}
struct RecepiMaker: View {

    let Recipe: RecepiBook

    var body: some View {

        Text("Test")
    }
}

#Preview {
    ContentView()
}
