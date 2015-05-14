package org.unq.epers.grupo5.rentauto

import java.util.Date
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.unq.epers.grupo5.rentauto.daos.SessionManager
import org.unq.epers.grupo5.rentauto.entities.Usuario
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.model.Reserva
import org.unq.epers.grupo5.rentauto.model.Turismo
import org.unq.epers.grupo5.rentauto.model.Ubicacion
import org.unq.epers.grupo5.rentauto.servicios.AutoManager

class AutoTest {
	var AutoManager autoMgr = new AutoManager()
	var Ubicacion ranelagh
	var Ubicacion quilmes
	var Ubicacion bera
	var Auto bmw
	var Auto ferrari
	var Auto torino
	var Turismo turismo1
	var Reserva reserva
	var Usuario usuario
	@Before
	def void setUp() {
		ranelagh = new Ubicacion()
		quilmes = new Ubicacion()
		bera = new Ubicacion()

		ranelagh.nombre = "Ranelagh"
		quilmes.nombre = "Quilmes"
		bera.nombre = "Bera"
		
		bmw = new Auto
		ferrari = new Auto
		torino = new Auto
		
		turismo1 = new Turismo()
		turismo1.nombre = "nombreTurismo"

		

		bmw.marca = "BMW"
		bmw.modelo = "C600"
		bmw.anio = 1999
		bmw.patente = "AABB123"
		bmw.costoBase = 12.4
		bmw.categoria = turismo1
		bmw.ubicacionInicial = ranelagh
		
		ferrari.marca = "Ferrari"
		ferrari.modelo = "Spider"
		ferrari.anio = 1999
		ferrari.patente = "HOLAB123"
		ferrari.costoBase = 12.4
		ferrari.categoria = turismo1
		ferrari.ubicacionInicial = bera
		
		torino.marca = "Torino"
		torino.modelo = "El unico"
		torino.anio = 1999
		torino.patente = "JOSE435"
		torino.costoBase = 12.4
		torino.categoria = turismo1
		torino.ubicacionInicial = quilmes

		usuario = new Usuario("nombre", "apellido", "nombreDEusser", "email", new Date(7), "contrasenha")
	
	}
	
	@After
	def void after(){
		SessionManager.truncate
	}

	@Test
	def testAutosEnUbicacion() 
	{
		autoMgr.guardar(bmw);
		autoMgr.guardar(torino);
		autoMgr.guardar(ferrari);
		autoMgr.reservar(bmw,usuario,2,quilmes,bera,new Date(115,3,5),new Date(2015,3,8))		

		val resultado = autoMgr.autosDisponiblesEnUbicacionYDia(bera,new Date(2015,9,7))
		
		Assert.assertTrue(resultado.map[ patente ].contains(bmw.patente) )
		Assert.assertTrue(resultado.map[ patente ].contains(ferrari.patente) )
		Assert.assertFalse(resultado.map[ patente ].contains(torino.patente) )
		
	}

	/*
	@Test
	def testHacerReserva() {
		autoMgr.hacerReserva(1,quilmes,ranelagh,new Date(3/5/5),new Date(5/8/5),a,usuario)		
		Assert.assertEquals(reserva.auto.patente,servicios.dameReserva(1).auto.patente)
		
	}

	@Test
	def void testAutosPosiblesEn() {
		Assert.assertEquals(1,
			servicios.autosPosiblesEn(quilmes, ranelagh, new Date(3/ 5 / 5), new Date(5/ 8 / 5), turismo1).size)
		
		servicios.guardarAuto(b)
		Assert.assertEquals(2,
			servicios.autosPosiblesEn(quilmes, ranelagh, new Date(3/ 5 / 5), new Date(5/ 8 / 5), turismo1).size)
			
		
		servicios.hacerReserva(1,quilmes,ranelagh,new Date(3/5/5),new Date(5/8/9),a,usuario)
		Assert.assertEquals(1,
			servicios.autosPosiblesEn(quilmes, ranelagh, new Date(3/ 6 / 5), new Date(5/ 9 / 5), turismo1).size)
		
		Assert.assertEquals(2,
			servicios.autosPosiblesEn(quilmes, ranelagh, new Date(3/ 6 / 15), new Date(5/ 9 / 15), turismo1).size)
			
		servicios.hacerReserva(2,quilmes,ranelagh,new Date(3/5/5),new Date(5/9/9),a,usuario)
		Assert.assertEquals(0,
			servicios.autosPosiblesEn(quilmes, ranelagh, new Date(3/ 4 / 6), new Date(5/ 9 / 6), turismo1).size)
		
			
	}
	
	*/

}
