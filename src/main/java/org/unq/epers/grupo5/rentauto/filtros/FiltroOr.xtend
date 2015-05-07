package org.unq.epers.grupo5.rentauto.filtros

import org.unq.epers.grupo5.rentauto.filtros.FiltroCompuesto

class FiltroOr extends FiltroCompuesto {
	
	new(Filtro... args) {
		super(args)
	}
	
	override conector() {
		"or"
	}
	
}