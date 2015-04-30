package org.unq.epers.grupo5.rentauto.exceptions

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException

class EntidadYaExisteException extends BusinessException {
	
	new(MySQLIntegrityConstraintViolationException exception) {
		super(exception)
	}
	
}