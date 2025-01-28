//
//  CoffeeView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-16.
//

import SwiftUI
import SwiftData

struct CoffeeView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingSheet = false
    ///@Query(sort: \CoffeeModel.price)
    @Query(filter: #Predicate<CoffeeModel>{$0.price > 100}, sort: (\CoffeeModel.price))
    var coffeeList: [CoffeeModel]
    @State private var coffeeToEdit: CoffeeModel?
//    let container: ModelContainer = {
//        let schema = Schema([CoffeeModel.self])
//        let container = try! ModelContainer(for: schema, configurations: [] )
//        return container
//    }()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(coffeeList){ coffee in
                    coffeeCell(coffeeDetails: coffee)
                        .onTapGesture {
                            coffeeToEdit = coffee
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet{
                        context.delete(coffeeList[index])
                    }
                }
            }
        }
        .navigationTitle("Coffee")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isShowingSheet){AddCoffeeSheet()}
        .sheet(item: $coffeeToEdit) { coffee in
            updateCoffeeSheet(coffeeList: coffee)
        }
        .toolbar{
            if !coffeeList.isEmpty {
                Button("Add Coffee", systemImage: "cup"){
                    isShowingSheet = true
                }
            }
        }
        .overlay{
            if coffeeList .isEmpty{
                ContentUnavailableView(label: {
                    Label( "No Coffee In List", systemImage:"mug")}, description: {Text("Start adding coffee in list")}, actions:{ Button("Add Coffee"){isShowingSheet = true}
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
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @State var UserCoffee: String = ""
    @State var Price: Double = 0
    
    var body: some View{
        NavigationStack{
            Form{
                TextField("Add Coffee Name Here", text: $UserCoffee)
                TextField("Add Coffee Price Here", value: $Price, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
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
                        let coffee = CoffeeModel(name: UserCoffee, price: Price)
                        context.insert(coffee)
                        
                        //try! context.save()   --If you want to save manually
                        dismiss()
                    }
                }
            }
        }
    }
}

struct updateCoffeeSheet: View{
    @Environment(\.dismiss) private var dismiss
    @Bindable var coffeeList: CoffeeModel
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Add Coffee Name Here", text: $coffeeList.name)
                TextField("Add Coffee Price Here", value: $coffeeList.price, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Coffee Detail")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    CoffeeView()
}
