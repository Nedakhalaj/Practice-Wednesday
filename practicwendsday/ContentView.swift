//
//  ContentView.swift
//  practicwendsday
//
//  Created by neda khalajnejad on 2026-03-25.
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let ingredient: [String]
    let difficulty: String
    let instruction: String
    let time: Int
}

struct ContentView: View {
    @State var recipeBook = [
        Recipe(
            title: "Pannkakor",
            ingredient: ["Oil", "flour", "sugar"],
            difficulty: "easy",
            instruction:
                "Mix flour, milk, eggs, sugar, and baking powder into a smooth batter, pour onto a hot pan.",
            time: 15
        ),
        Recipe(
            title: "Lasagna",
            ingredient: ["meat", "spices","lasagna sheet"],
            difficulty: "medium",
            instruction: "cookes layer by layer",
            time: 60
        ),
        Recipe(
            title: "Tacos",
            ingredient: ["beef", "tomato paste","tortilla"],
            difficulty: "hard",
            instruction: "fried meat with veggies",
            time: 20
        ),
        Recipe(
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
    @State var searchText = ""
    
    var filteredBooks: [Recipe]{
        if searchText.isEmpty{
            return recipeBook
        }
        return recipeBook.filter{book in book.title.contains(searchText)
        }
    }
    var body: some View {
        
        TabView {
            Tab("Recipes", systemImage: "book") {
                NavigationStack {
                    List {
                        ForEach(filteredBooks) { book in
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
                            recipeBook.remove(atOffsets: IndexSet)
                        }
                    }
                    .searchable(text: $searchText,prompt: "search here")
                    .navigationTitle("Recipe Book")
                    
                }
            }
            Tab("Create", systemImage: "fork.knife") {
                RecepiMaker(recipe: $recipeBook)
            }
        }
    }
}
struct DetailView: View {
    let Recipe: Recipe
    var body: some View {
        
        List{
            Text(Recipe.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack {
                Text("Igreedients:")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    ForEach(Recipe.ingredient, id: \.self) { ingreident in
                        Text(ingreident)
                    
                    }
                } // Hstack end here
                
            }
            Text(Recipe.instruction)
                .padding(20)
        }
        
    }
}



struct RecepiMaker: View {
    
    @Binding var recipe: [Recipe]
    
    @State var newTitle: String = ""
    @State var newIngredient: [String] = [ ]
    @State var ingredientInput: String = ""
    @State var newDifficulty: String = "easy"
    @State var newInstruction: String = ""
    @State var newTime: Int = 0
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray)
                .opacity(0.3)
                .frame(height:500)
            
            VStack {
                Text("Add Recipe")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Recipe Name", text: $newTitle)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
                HStack{
                    TextField("Ingredients", text: $ingredientInput)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    Button {
                        newIngredient.append(ingredientInput)
                        ingredientInput = ""
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color(.blue))
                    .foregroundColor(.white)
                    .cornerRadius(24)
                } // Hstack end
                    if (newIngredient.count > 0) {
                        ScrollView(.horizontal){
                            HStack{
                            ForEach(newIngredient, id: \.self) { ingreduen in
                                Text(ingreduen)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                            }
                        }
                    }
                } // ingredient list
                HStack{
                    Text("Difficulty selector")
                    Picker("Difficulty", selection: $newDifficulty){
                        Text("Easy").tag("easy")
                        Text("Medium").tag("Medium")
                        Text("Hard").tag("Hard")
                    }
                }
                TextField("Instructions", text: $newInstruction)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                TextField("Cooking time", value: $newTime, format: .number)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                Button("Add Recipe") {
                    recipe.append(
                        Recipe(
                            title: newTitle,
                            ingredient: newIngredient,
                            difficulty: newDifficulty,
                            instruction: newInstruction,
                            time: newTime
                        )
                    )
                    newTitle = ""
                    newIngredient = [""]
                    newDifficulty = ""
                    newInstruction = ""
                    newTime = 0
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
    
}
