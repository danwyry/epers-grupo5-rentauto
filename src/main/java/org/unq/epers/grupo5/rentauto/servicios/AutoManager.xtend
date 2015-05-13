package org.unq.epers.grupo5.rentauto.servicios

import java.util.List
import org.unq.epers.grupo5.rentauto.daos.SessionManager
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.daos.AutoDao
import org.unq.epers.grupo5.rentauto.model.Ubicacion
import java.util.Date

class AutoManager {
	
	public def List<Auto>  autosDisponiblesEnUbicacionYDia(Ubicacion ubicacion, Date dia)
	{
		SessionManager.runInSession[| 
			new AutoDao().disponiblesEnUbicacionUnDia(ubicacion, dia)
		]
		
	}
	
	
}