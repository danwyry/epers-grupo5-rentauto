package org.unq.epers.grupo5.rentauto.daos

import org.unq.epers.grupo5.rentauto.daos.Dao
import org.unq.epers.grupo5.rentauto.model.Ubicacion

class UbicacionDao extends Dao<Ubicacion> {
	
	new(Class daoClass) {
		super(new Ubicacion.class)
	}
	
}