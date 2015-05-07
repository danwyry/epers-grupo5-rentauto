package org.unq.epers.grupo5.rentauto

import org.unq.epers.grupo5.rentauto.model.Auto
import org.unq.epers.grupo5.rentauto.servicios.AutoManager

public class ConsultarTest extends AbstractHibernateTest {
	def void testApp(){
		var Auto a = new AutoManager().consultarAuto(1);
		assertEquals("Batman", a.getApellido());
		assertEquals("JugadorX", a.getNombre());
		assertEquals(99, (int) a.getNroCamiseta());
	}

}
