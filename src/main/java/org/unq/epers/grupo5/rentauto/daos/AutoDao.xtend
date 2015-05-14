package org.unq.epers.grupo5.rentauto.daos

import java.util.Date
import org.hibernate.Query
import org.hibernate.classic.Session
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.model.Ubicacion
import java.util.List
import org.unq.epers.grupo5.rentauto.filtros.FiltroConcreto
import org.unq.epers.grupo5.rentauto.filtros.FiltroOr
import org.unq.epers.grupo5.rentauto.filtros.FiltroSimple
import org.unq.epers.grupo5.rentauto.filtros.FiltroAnd

class AutoDao extends Dao<Auto> {
	new () {
		super(new Auto.class)
	}
	
	def List<Auto> disponiblesEnUbicacionUnDia(Ubicacion ubicacion, Date dia)
	{
		var Session sess = SessionManager.getSession();
		var Query q = sess.createQuery("
			from Auto as auto
		 	left join fetch auto.reservas as reservas 
			where 
			( 
				reservas.id is null	and auto.ubicacionInicial = :ubicacion	
			) or ( 
				auto in (
					select fRes.auto
					from Reserva as fRes
					where 		fRes.destino = :ubicacion
							and fRes.fin = (
								select max(fRes2.fin) as reserva_id 
								from Reserva as fRes2 
								where 	fRes2.fin < :diaReserva
									and fRes2.auto = fRes.auto
							)
				)
				and auto not in (
					select fRes3.auto
					from Reserva as fRes3 
					where 		fRes3.inicio <= :diaReserva 
							and fRes3.fin 	>= :diaReserva
				)
			)
		")

		q.setParameter("ubicacion", ubicacion)
		q.setParameter("diaReserva" , dia)
		q.list
	}
}



class FiltroAutoDisponibleEnUbicacionYFecha extends FiltroConcreto {
	new () {
		super(
			new FiltroOr(
				new FiltroAnd( //-- AUTOS QUE NO TENGAN NINGUNA RESERVA 
					new FiltroSimple("reservas.id is null"), 
					new FiltroSimple("auto.ubicacion_inicial = :ubicacion")
				), 
				
				new FiltroAnd( //-- AUTOS CUYA ULTIMA UIBCACION HASTA :diaReserva FUE :ubicacionReserva
					new FiltroSimple("
						auto.id in (
							select fRes.auto_id
							from Reservas as fRes
							where 		fRes.destino == :ubicacionReserva
									and fRes.fin = (
										select max(fRes2.fin) as reserva_id 
										from Reservas as fRes2 
										where 	fRes2.fin < :diaReserva
											and fRes2.auto_id = fRes.auto_id
									)
						)"), 
					new FiltroSimple("
						auto.id not in (
							-- AUTOS QUE NO TENGAN RESERVA EN :diaReserva
							select fRes3.auto_id
							auto.Reservas as fRes3 
							where 		fRes3.inicio <= :diaReserva 
									and fRes3.fin 	>= :diaReserva
						)")
				
				)
			)
		)
	}

}