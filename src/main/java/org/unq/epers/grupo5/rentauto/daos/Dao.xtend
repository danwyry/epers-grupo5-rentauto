package org.unq.epers.grupo5.rentauto.daos

abstract class Dao<T> {
		private val Class daoClass ;  

		new (Class daoClass) {
			this.daoClass = daoClass
		}

		def T get(int id){
		 return  SessionManager.getSession().get(this.daoClass,id) as T;
	}

	def void save(T j) {
		SessionManager.getSession().saveOrUpdate(j);
	}
	
}