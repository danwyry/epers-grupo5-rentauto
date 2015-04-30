package org.unq.epers.grupo5.rentauto.daos

import org.unq.epers.grupo5.rentauto.daos.Dao
import org.unq.epers.grupo5.rentauto.model.Empresa

class EmpresaDao extends Dao<Empresa> {	
	new(Class daoClass) {
		super(new Empresa.class)
	}
	
}