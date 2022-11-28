//
//  CoreDataManager.swift
//  CRUD-Swift
//
//  Created by Juan Hernandez on 22/11/22.
//

import Foundation
import CoreData
import CoreText

class CoreDataManager {
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "Empleados")
        persistentContainer.loadPersistentStores(completionHandler: {
            (descripcion, error) in
            if let error = error {
                fatalError("Error al inicializar core data \(error.localizedDescription)")
            }
        })
    }
    
    func guardarEmpleado(id: String, empNombre: String, empApePat: String, empApeMat: String, domicilio: String, telefono: String, puesto: String, activo_opc: String ){
        let empleado = Empleados(context: persistentContainer.viewContext)
        empleado.id = id
        empleado.empNombre = empNombre
        empleado.empApePat = empApePat
        empleado.empApeMat = empApeMat
        empleado.domicilio = domicilio
        empleado.telefono = telefono
        empleado.puesto = puesto
        empleado.activo_opc = activo_opc
        
        do {
            try persistentContainer.viewContext.save()
            print("empleado guardado")
        }
        catch{
            print("error al guardar, error en \(error)")
        }
    }
    
    func leerEmpleados() -> [Empleados]{
        let fetchRequest: NSFetchRequest<Empleados> = Empleados.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return []
        }
    }
    
    func borrarEmpleado(empleado: Empleados) {
        persistentContainer.viewContext.delete(empleado)
        
        do {
            try persistentContainer.viewContext.save()
        }
        catch{
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    func leerEmpleado(id: String) -> Empleados?{
        let fetchRequest: NSFetchRequest<Empleados> = Empleados.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", id)
        fetchRequest.predicate = predicate
        
        do {
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            return datos.first
        }
        catch{
            print("Error al guardar, error en \(error)")
        }
        return nil
    }
    
    func actualizarEmpleado(empleado: Empleados){
        let fetchRequest: NSFetchRequest<Empleados> = Empleados.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", empleado.id ?? "")
        fetchRequest.predicate = predicate
        
        //var emp = persistentContainer.viewContext.updatedObjects(empleado)

        do {
            let datos = try persistentContainer.viewContext.fetch(fetchRequest)
            let e = datos.first
            e?.id = empleado.id
            e?.empNombre = empleado.empNombre
            e?.empApePat = empleado.empApePat
            e?.empApeMat = empleado.empApeMat
            e?.domicilio = empleado.domicilio
            e?.telefono = empleado.telefono
            e?.puesto = empleado.puesto
            e?.activo_opc = empleado.activo_opc
            try persistentContainer.viewContext.save()
            print("empleado guardado")
        }
        catch{
            print("error al guardar, error en \(error)")
        }
    }
    
}
