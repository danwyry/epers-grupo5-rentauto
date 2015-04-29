package org.unq.epers.grupo5.rentauto.daos

import org.hibernate.SessionFactory
import org.hibernate.Transaction
import org.hibernate.cfg.Configuration
import org.hibernate.classic.Session
import org.unq.epers.grupo5.rentauto.servicios.Operation

class SessionManager {
		
	private static var SessionFactory sessionFactory;
	private static var ThreadLocal<Session> tlSession = new ThreadLocal<Session>();

	def synchronized static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			var Configuration cfg = new Configuration();
			cfg.configure();

			sessionFactory = cfg.buildSessionFactory();
		}

		return sessionFactory;
	}
	
	def static <T> T runInSession(Operation<T> cmd){
		var SessionFactory sessionFactory = SessionManager.getSessionFactory();
		var Transaction transaction = null;
		var T result = null;
		var Session session = null;
		
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();

			tlSession.set(session);
			
			result = cmd.execute();

			session.flush();
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null)
				transaction.rollback();
			throw new RuntimeException(e);
		} finally {
			if (session != null)
				session.close();
			tlSession.set(null);
		}
		
		return result;
	}

	def static Session getSession() {
		return tlSession.get();
	}
}