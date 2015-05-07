package org.unq.epers.grupo5.rentauto.filtros

import org.unq.epers.grupo5.rentauto.filtros.Filtro

abstract class FiltroUnario extends Filtro {
	
	Filtro filtro ; 
	
	override query() {
		operador + " (" filtro.query + ")"
	}
	
	abstract def String operador(); 
}