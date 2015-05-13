package org.unq.epers.grupo5.rentauto.servicios.filtros

import java.util.Date
import org.unq.epers.grupo5.rentauto.filtros.Filtro
import org.unq.epers.grupo5.rentauto.filtros.FiltroAnd
import org.unq.epers.grupo5.rentauto.model.Ubicacion
import org.unq.epers.grupo5.rentauto.filtros.FiltroConcreto

class FiltroAutoDisponibleEnUbicacionYFecha extends FiltroConcreto {
	new (Ubicacion ubicacion, Date fecha) {
		super(
			new FiltroAnd( 
				new FiltroAutoDisponibleEnFecha(fecha) , 
				new FiltroAutoConUbicacionEnFecha(ubicacion,fecha)
			)
		)
	}

	override query() {
		filtro.query
	}

}