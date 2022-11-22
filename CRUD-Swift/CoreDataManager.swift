//
//  CoreDataManager.swift
//  CRUD-Swift
//
//  Created by CCDM01 on 22/11/22.
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
    
    func guardarEmpleado(empNombre: String, empApePat: String, empApeMat: String, domicilio: String, telefono: String, puesto: String, activo_opc: Int16 ){
        let empleado = Empleados(context: persistentContainer.viewContext)
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
    
}
