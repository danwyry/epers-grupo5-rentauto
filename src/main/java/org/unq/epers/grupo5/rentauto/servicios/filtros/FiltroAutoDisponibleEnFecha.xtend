package org.unq.epers.grupo5.rentauto.servicios.filtros

import java.util.Date
import org.unq.epers.grupo5.rentauto.filtros.FiltroAnd
import org.unq.epers.grupo5.rentauto.filtros.FiltroConcreto
import org.unq.epers.grupo5.rentauto.filtros.FiltroNot
import org.unq.epers.grupo5.rentauto.filtros.FiltroSimple

class FiltroAutoDisponibleEnFecha extends FiltroConcreto {
	
	new(Date date) {
		super(
			new FiltroNot(
				new FiltroAnd(
					new FiltroSimple("auto.reservas.inicio <= :fechaDisponibilidad"), 
					new FiltroSimple("auto.reservas.fin >= :fechaDisponibilidad")
				)
			)
		)
	}

	//	 	not (auto.reservas.inicio <= ? and auto.reservas.fin >= ?)
	
}