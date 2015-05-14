package org.unq.epers.grupo5.rentauto

import java.util.Date
import org.junit.After
import static org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.unq.epers.grupo5.rentauto.daos.SessionManager
import org.unq.epers.grupo5.rentauto.entities.Usuario
import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.model.Familiar
import org.unq.epers.grupo5.rentauto.model.Turismo
import org.unq.epers.grupo5.rentauto.model.Ubicacion
import org.unq.epers.grupo5.rentauto.servicios.AutoManager
import java.util.List

class AutoTest {
	var AutoManager autoMgr = new AutoManager()
	
	var Ubicacion ranelagh = new Ubicacion()
	var Ubicacion quilmes = new Ubicacion()
	var Ubicacion bera = new Ubicacion()

	var Auto bmw
	var Auto ferrari
	var Auto torino
	var Auto fitito 
	var Auto quinientos4

	var Turismo turismo1 = new Turismo()
	var Familiar familiar = new Familiar()

	var Usuario usuario

	@Before
	def void setUp() {
		ranelagh.nombre = "Ranelagh"
		quilmes.nombre = "Quilmes"
		bera.nombre = "Bera"

		turismo1.nombre = "Turismo"
		familiar.nombre = "familiar"

		bmw = new Auto("BMW", "C600", 1999, "AABB123", turismo1, 12.4, ranelagh)
		ferrari = new Auto("Ferrari", "Spider", 1999, "ASD436", turismo1,  12.4, bera)
		quinientos4 = new Auto("Peugeot", "504", 1985, "FES112", familiar, 10.5, bera)		
		fitito = new Auto("Fiat", "600", 1981, "WWR523", familiar, 12.3, quilmes)
		torino = new Auto("Torino", "El unico", 1990, "ASR523", turismo1, 12.3, quilmes)

		autoMgr.guardar(bmw);
		autoMgr.guardar(torino);
		autoMgr.guardar(ferrari);
		autoMgr.guardar(fitito);
		autoMgr.guardar(quinientos4);

		usuario = new Usuario("nombre", "apellido", "nombreDEusser", "email", new Date(7), "contrasenha")
	
	}
	
	@After
	def void after(){
		SessionManager.truncate
	}

	@Test
	def testReservar() {
		var _inicio = new Date(2015,1,1)
		var _fin = new Date(2015,1,10)
		
		assertEquals(fitito.reservas.size, 0)
		
		var reserva = autoMgr.reservar(fitito, usuario, 8, quilmes, ranelagh, _inicio, _fin)
		
		assertEquals(fitito.reservas.size, 1)
	}	

	def boolean autoEnResultado(Auto auto, List<Auto> resultado ) 
	{
		resultado.map[ patente ].contains(auto.patente)
	}

	@Test
	def testAutosDisponiblesEnUbicacionYDia() 
	{
		autoMgr.reservar(bmw,usuario,2,ranelagh,bera,new Date(2015,3,5), new Date(2015,3,8))		

		val resultado = autoMgr.autosDisponiblesEnUbicacionYDia(bera, new Date(2015,9,7))

		assertTrue(	autoEnResultado(bmw, resultado) )
		assertTrue(	autoEnResultado(ferrari, resultado) )
		assertFalse(	autoEnResultado(torino, resultado) )
	}

	@Test
	def testAutosDisponiblesParaReservarEn_SiNoHayReservasDevuelveLosQueCoincidenConUbicacionInicialYCategoria()
	{
		var resultado = autoMgr.autosDisponiblesParaReservarEn(ranelagh, ranelagh, new Date(2015, 1,12) , new Date(2015, 1,16) , turismo1)

		assertTrue(	autoEnResultado(bmw, resultado) )
		assertFalse(	autoEnResultado(ferrari, resultado) )
		assertFalse(	autoEnResultado(torino, resultado) )		
		assertFalse(	autoEnResultado(quinientos4, resultado) )
		assertFalse(	autoEnResultado(fitito, resultado) )

		resultado = autoMgr.autosDisponiblesParaReservarEn(ranelagh, ranelagh, new Date(2015, 1,12) , new Date(2015, 1,16) , familiar)

		assertFalse(	autoEnResultado(bmw, resultado) )
		assertFalse(	autoEnResultado(ferrari, resultado) )
		assertFalse(	autoEnResultado(torino, resultado) )
		assertFalse(	autoEnResultado(quinientos4, resultado) )
		assertFalse(	autoEnResultado(fitito, resultado) )

		resultado = autoMgr.autosDisponiblesParaReservarEn(quilmes, ranelagh, new Date(2015, 1,12) , new Date(2015, 1,16) , familiar)

		assertTrue(	autoEnResultado(fitito, resultado) )
		assertFalse(	autoEnResultado(bmw, resultado) )
		assertFalse(	autoEnResultado(ferrari, resultado) )
		assertFalse(	autoEnResultado(torino, resultado) )
		assertFalse(	autoEnResultado(quinientos4, resultado) )

	}

	@Test
	def testAutosDisponiblesParaReservarEn_SiHayReservasDevuelveLosQueCorresponden()
	{

		autoMgr.reservar(ferrari ,usuario ,3 ,bera, quilmes, new Date(2015,1,1), new Date(2015,1,10))
		autoMgr.reservar(quinientos4 ,usuario ,4 ,bera, ranelagh, new Date(2015,1,1), new Date(2015,1,10))
		autoMgr.reservar(quinientos4 ,usuario ,5 ,ranelagh, ranelagh, new Date(2015,1,20), new Date(2015,1,25))	
		autoMgr.reservar(fitito, usuario, 6, quilmes, ranelagh, new Date(2015,1,1), new Date(2015,1,10))		

		var resultado = autoMgr.autosDisponiblesParaReservarEn(quilmes, ranelagh, new Date(2015, 1,12) , new Date(2015, 1,16) , turismo1)

		assertTrue(		autoEnResultado(ferrari, resultado) )
		assertTrue(		autoEnResultado(torino, resultado) )
		assertFalse(	autoEnResultado(fitito, resultado) )
		assertFalse(	autoEnResultado(quinientos4, resultado) )
		assertFalse(	autoEnResultado(bmw, resultado) )

		resultado = autoMgr.autosDisponiblesParaReservarEn(ranelagh, ranelagh, new Date(2015, 1,12) , new Date(2015, 1,16) , familiar)
		
		assertTrue(	autoEnResultado(quinientos4, resultado) )
		assertTrue(	autoEnResultado(fitito, resultado) )
		assertFalse(	autoEnResultado(ferrari, resultado) )
		assertFalse(	autoEnResultado(torino, resultado) )
		assertFalse(	autoEnResultado(bmw, resultado) )
		
	}

}
