package org.unq.epers.grupo5.rentauto.servicios.filtros

import java.util.Date
import org.unq.epers.grupo5.rentauto.filtros.FiltroConcreto
import org.unq.epers.grupo5.rentauto.filtros.FiltroSimple
import org.unq.epers.grupo5.rentauto.model.Ubicacion

class FiltroAutoConUbicacionEnFecha extends FiltroConcreto {
	
	new(Ubicacion ubicacion, Date fecha) {
		super (
			new FiltroSimple("
				auto.id in (
					select id 
					from Reserva as reserva 
					where reserva
				)
			")
		)
	}
	
	
	
}