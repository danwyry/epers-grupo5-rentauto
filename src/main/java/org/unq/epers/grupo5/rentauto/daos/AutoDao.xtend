package org.unq.epers.grupo5.rentauto.daos

import java.util.Date
import org.hibernate.Query
import org.hibernate.classic.Session
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.model.Ubicacion

class AutoDao extends Dao<Auto> {
	new () {
		super(new Auto.class)
	}
	
	def void DisponiblesEnUbicacionUnDia(Ubicacion ubicacion, Date dia)
	{
		var Session sess = SessionManager.sessionFactory.currentSession;
		var Query q = sess.createQuery("
			from Auto as auto
			left join Reservas as reservas 
			where 
			-- AUTOS QUE NO TENGAN NINGUNA RESERVA 
			( 
				reservas.id is null	and auto.ubicacion_inicial = :ubicacion	
			) or ( 
				auto.id in (
					-- AUTOS CUYA ULTIMA UIBCACION FUE :ubicacionReserva
					select fRes.auto_id
					from Reservas as fRes
					where 		fRes.destino == :ubicacionReserva
							and fRes.fin = (
								select max(fRes2.fin) as reserva_id 
								from Reservas as fRes2 
								where 	fRes2.fin < :diaReserva
									and fRes2.auto_id = fRes.auto_id
							)
				)
				and auto.id not in (
					-- AUTOS QUE NO TENGAN RESERVA EN :diaReserva
					select fRes3.auto_id
					auto.Reservas as fRes3 
					where 		fRes3.inicio <= :diaReserva 
							and fRes3.fin 	>= :diaReserva
				)
			)
		")
		
		list
	}
}