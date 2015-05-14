package org.unq.epers.grupo5.rentauto.daos

abstract class Dao<T> {
		protected val Class daoClass ;  

		new (Class daoClass) {
			this.daoClass = daoClass
		}

		def T get(int id){
		 return  SessionManager.getSession().get(this.daoClass,id) as T;
	}

	def save(T e) {
		SessionManager.getSession().saveOrUpdate(e);
		e
	}
	
}