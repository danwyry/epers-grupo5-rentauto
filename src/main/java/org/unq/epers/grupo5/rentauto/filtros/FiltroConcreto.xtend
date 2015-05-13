package org.unq.epers.grupo5.rentauto.filtros

import org.unq.epers.grupo5.rentauto.filtros.Filtro

abstract class FiltroConcreto extends Filtro {
	
	protected val Filtro filtro 

	new (Filtro filtro) {
		this.filtro = filtro
	}

	override query() {
		filtro.query
	}
	
}