package org.unq.epers.grupo5.rentauto.daos

import org.unq.epers.grupo5.rentauto.daos.Dao
import org.unq.epers.grupo5.rentauto.model.Reserva

class ReservaDao extends Dao<Reserva> {
	
	new(Class daoClass) {
		super(new Reserva.class)
	}
	
}