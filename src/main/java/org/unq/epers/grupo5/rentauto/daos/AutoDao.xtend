package org.unq.epers.grupo5.rentauto.daos

import java.util.Date
import org.hibernate.classic.Session
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.model.Ubicacion

class AutoDao extends Dao<Auto> {
	new () {
		super(new Auto.class)
	}
	
	def findByCriteria() {
	
	}
	
	def void DisponiblesEnUbicacionUnDia(Ubicacion ubicacion, Date dia)
	{
		var Session sess = SessionManager.sessionFactory.currentSession;
		sess .createQuery("
			 from Auto as auto
				where 
					not (auto.reservas.inicio <= ? and auto.reservas.fin >= ?)
					and (
					)						
		")
	}
	
	
	/* 
	def seSuperpone(Date desde, Date hasta){
		if(inicio <= desde && desde <= fin )
			return true
		if(inicio <= hasta && hasta <= fin )
			return true
		if(desde <= inicio && fin <= hasta)
			return true
			
		return false	
	}

 	def ubicacionParaDia(Date unDia){
		val encontrado = reservas.findLast[ it.fin <= unDia ]
		if(encontrado != null){
			return encontrado.destino
		}else{
			return ubicacionInicial
		}
	}
	 
	  .createCriteria(Cat.class)
    .add( Restrictions.like("name", "Fritz%") )
    .add( Restrictions.between("weight", minWeight, maxWeight) )
    .list();*/
    
	
}