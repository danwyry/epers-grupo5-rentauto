package org.unq.epers.grupo5.rentauto.daos

import org.unq.epers.grupo5.rentauto.daos.Dao
import org.unq.epers.grupo5.rentauto.entities.Usuario

class UsuarioDao extends Dao<Usuario> {
	
	new(Class daoClass) {
		super(new Usuario.class)
	}
	
}