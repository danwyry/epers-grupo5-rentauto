package org.unq.epers.grupo5.rentauto.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Ubicacion {
	int id
	String nombre
	
	new(String nombre){
		this.nombre = nombre
	}
	
	new() {
		
	}
	
}

@Accessors 
class UbicacionVirtual extends Ubicacion{
	List<Ubicacion> ubicaciones
}
