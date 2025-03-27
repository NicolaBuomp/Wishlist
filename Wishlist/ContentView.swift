//
//  ContentView.swift
//  Wishlist
//
//  Created by Nicola Buompane on 27/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var showAddWishModal: Bool = false
    @State private var titleTextField: String = ""
    
    @Query private var wishes: [Wish]
    var body: some View {
        NavigationStack {
            List {
                ForEach(wishes) { wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(wish)
                            }
                        }
                }
            } //: LIST
            .navigationTitle("Wishlist")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddWishModal.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                if wishes.isEmpty != true {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }
            }
            .alert("Create a new wish", isPresented: $showAddWishModal) {
                TextField("Enter a wish", text: $titleTextField)
                Button {
                    modelContext.insert(Wish(title: titleTextField))
                    titleTextField = ""
                } label: {
                    Text("Add")
                }
                Button {} label: {
                    Text("Close")
                }
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView("My Wishlist is empty.", systemImage: "heart.circle", description: Text("Add your first wish!"))
                }
            }
        }
    }
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}

#Preview("List with simple data") {
    do {
        let container = try ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        context.insert(Wish(title: "Test Wish 1"))
        context.insert(Wish(title: "Test Wish 2"))
        context.insert(Wish(title: "Test Wish 3"))
        context.insert(Wish(title: "Test Wish 4"))

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to load preview: \(error.localizedDescription)")
    }
}
