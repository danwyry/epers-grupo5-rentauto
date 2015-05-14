package org.unq.epers.grupo5.rentauto.servicios

import java.util.Date
import java.util.List
import org.unq.epers.grupo5.rentauto.daos.AutoDao
import org.unq.epers.grupo5.rentauto.daos.SessionManager
import org.unq.epers.grupo5.rentauto.entities.Usuario
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.model.Reserva
import org.unq.epers.grupo5.rentauto.model.Ubicacion
import org.unq.epers.grupo5.rentauto.daos.ReservaDao

class AutoManager {
	
	public def guardar(Auto auto) 
	{
		SessionManager.runInSession[ |
			new AutoDao().save(auto)
		]
	}
	
	public def List<Auto>  autosDisponiblesEnUbicacionYDia(Ubicacion ubicacion, Date dia)
	{
		SessionManager.runInSession[| 
			new AutoDao().disponiblesEnUbicacionUnDia(ubicacion, dia)
		]
		
	}
	public def reservar(Auto auto, Usuario usuario, Integer numSolicitud, Ubicacion origen, Ubicacion destino, Date inicio, Date fin )
	{
		SessionManager.runInSession[ | 
			var reserva = new Reserva(numSolicitud, origen, destino, inicio, fin , auto, usuario)
			new ReservaDao().save(reserva)
		]
	}
	
	
}