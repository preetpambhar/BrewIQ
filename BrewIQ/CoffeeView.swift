//
//  CoffeeView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-16.
//

import SwiftUI
import SwiftData

struct CoffeeView: View {
    @State private var isShowingSheet = false
    var coffee: [CoffeeModel] = []
//    let container: ModelContainer = {
//        let schema = Schema([CoffeeModel.self])
//        let container = try! ModelContainer(for: schema, configurations: [] )
//        return container
//    }()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(coffee){ coffee in
                    coffeeCell(coffeeDetails: coffee)
                }
            }
        }
        .navigationTitle("Coffee")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isShowingSheet){AddCoffeeSheet()}
        .toolbar{
            if !coffee.isEmpty {
                Button("Add Coffee", systemImage: "cup"){
                    isShowingSheet = true
                }
            }
        }
        .overlay{
            if coffee.isEmpty{
                ContentUnavailableView(label: {
                    Label( "No Coffee In List", systemImage:"coffee")}, description: {Text("Start adding coffee in list")}, actions:{ Button("Add Coffee"){isShowingSheet = true}
                    })
                    .offset(y: -60)
            }
        }
           // .modelContainer(container)
            .modelContainer(for: [CoffeeModel.self])
    }
}

struct coffeeCell: View{
    let coffeeDetails: CoffeeModel
    var body: some View{
        HStack{
            Text(coffeeDetails.name)
            Spacer()
            Text("\(coffeeDetails.price)")
        }
    }
}
struct AddCoffeeSheet: View{
    @Environment(\.dismiss) private var dismiss
    @State var Coffee: String = ""
    @State var Price: Double = 0
    
    var body: some View{
        NavigationStack{
            Form{
                TextField("Add Coffee Name Here", text: $Coffee)
                TextField("Add Coffee Price Here", value: $Price, format: .currency(code: "USD"))
            }
            .navigationTitle("Coffee Detail")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Cancel") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Save"){
                        //Save code
                    }
                }
            }
        }
    }
}

#Preview {
    CoffeeView()
}
