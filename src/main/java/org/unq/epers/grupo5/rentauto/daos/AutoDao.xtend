package org.unq.epers.grupo5.rentauto.daos

import org.unq.epers.grupo5.rentauto.daos.Dao
import org.unq.epers.grupo5.rentauto.model.Auto

class AutoDao extends Dao<Auto> {
	new () {
		super(new Auto.class)
	}
}