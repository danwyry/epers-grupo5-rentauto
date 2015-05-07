package org.unq.epers.grupo5.rentauto.filtros

import java.util.ArrayList
import java.util.List

abstract class FiltroCompuesto extends Filtro {
	
	List<Filtro> filtros = new ArrayList<Filtro>
	
	new (Filtro ...args) {
		filtros = args
	}
	
	override query() {
		"(" + filtros.map[ it.query ].join( " " + conector + " " ) + ")"
	}

	 abstract def String conector() ;
}