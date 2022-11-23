//
//  ContentView.swift
//  CRUD-Swift
//
//  Created by Juan Hernandez on 17/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State var empNombre = ""
    @State var empApePat = ""
    @State var empApeMat = ""
    @State var domicilio = ""
    @State var telefono = ""
    @State var puesto = ""
    @State var activo_opc = ""
    @State var empsArray = [Empleados]()
    
    var body: some View{
        VStack{
            TextField("Nombre del empleado:", text: $empNombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Apellido Paterno:", text: $empApePat).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Apellido Materno:", text: $empApeMat).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Domicilio:", text: $domicilio).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Telefono:", text: $telefono).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Puesto:", text: $puesto).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Estado:", text: $activo_opc).textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save"){
                coreDM.guardarEmpleado(empNombre: empNombre, empApePat: empApePat, empApeMat: empApeMat, domicilio: domicilio, telefono: telefono, puesto: puesto, activo_opc: activo_opc)
                mostrarEmpleados()
                empNombre = ""
                empApePat = ""
                empApeMat = ""
                domicilio = ""
                telefono = ""
                puesto = ""
                activo_opc = ""
            }
            List{
                ForEach(empsArray, id: \.self){
                    emp in
                    VStack{
                        Text(emp.empNombre ?? "")
                        Text(emp.empApePat ?? "")
                        Text(emp.empApeMat ?? "")
                        Text(emp.domicilio ?? "")
                        Text(emp.telefono ?? "")
                        Text(emp.puesto ?? "")
                        Text(emp.activo_opc ?? "")
                    }
                }.onDelete(perform: {
                    indexSet in
                    indexSet.forEach({index in
                        let empleado = empsArray[index]
                        coreDM.borrarEmpleado(empleado: empleado)
                        mostrarEmpleados()
                    })
                })
            }
            Spacer()
        }.padding().onAppear(perform: {
            mostrarEmpleados()
            
        })
    }
    
    func mostrarEmpleados(){
        empsArray = coreDM.leerEmpleados()
    }
    
/*    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }*/
}
/*
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
*/
