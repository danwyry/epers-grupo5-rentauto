package org.unq.epers.grupo5.rentauto.filtros

import org.unq.epers.grupo5.rentauto.filtros.FiltroUnario

class FiltroNot extends FiltroUnario {
	
	new(Filtro filtro) {
		super(filtro)
	}
	
	override operador() {
		"not"
	}
	
}