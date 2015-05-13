package org.unq.epers.grupo5.rentauto.filtros

import org.unq.epers.grupo5.rentauto.filtros.Filtro

class FiltroSimple extends Filtro {
	val String condicion 
	
	new (String condicion) {
		this.condicion = condicion 
	}
	
	override query() {
		condicion
	}
	
}