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
import org.unq.epers.grupo5.rentauto.model.Categoria

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
	
	
	def List<Auto> disponiblesParaReservarEn(Ubicacion origen, Ubicacion destino, Date inicio , Date fin , Categoria categoria)
	{
		var Session sess = SessionManager.getSession() 
		var Query q = sess.createQuery("
			from Auto as auto
		 	left join fetch auto.reservas as reservas 
			where 
			auto.categoria = :categoria 
			and (
				( 
					reservas.id is null	and auto.ubicacionInicial = :origen	
				) or ( 
					auto in (
						select fRes.auto
						from Reserva as fRes
						where 		fRes.destino = :origen
								and fRes.fin = (
									select max(fRes2.fin) as reserva_id 
									from Reserva as fRes2 
									where 	fRes2.fin < :inicio
										and fRes2.auto = fRes.auto
								)
					)
					and (
						auto in (
							select fRes3.auto
							from Reserva as fRes3
							where 		fRes3.origen = :destino
									and fRes3.inicio = (
										select min(fRes4.inicio)  
										from Reserva as fRes4 
										where 	fRes4.inicio > :fin
											and fRes4.auto = fRes3.auto
									)
						) or auto not in (
							select fRes5.auto
							from Reserva as fRes5
							where fRes5.inicio > :fin
						)
					)
					and auto not in (
						select fRes6.auto
						from Reserva as fRes6 
						where 		:inicio between fRes6.inicio and fRes6.fin 	
								or  :fin between fRes6.inicio and fRes6.fin
					)
				)
			)
		")
		q.setParameter ('categoria', categoria)
		q.setParameter ('origen', origen)
		q.setParameter ('destino', destino)
		q.setParameter ('inicio', inicio)
		q.setParameter ('fin', fin)
		q.list
	}
}



/*class FiltroAutoDisponibleEnUbicacionYFecha extends FiltroConcreto {
	new () {
		super(
		)
	}

}*/