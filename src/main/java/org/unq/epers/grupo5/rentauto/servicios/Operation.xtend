package org.unq.epers.grupo5.rentauto.servicios

interface Operation<T> {
	def T execute();
}