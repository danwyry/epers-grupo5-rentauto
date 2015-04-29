package org.unq.epers.grupo5.rentauto.daos

abstract class Dao<T> {
		def T get(int id){
		return (T)SessionManager.getSession().get(T.class,id);
	}

	def void save(T j) {
		SessionManager.getSession().saveOrUpdate(j);
	}
	
}