package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Company;
import com.jacaranda.utiliy.BdUtil;

public class DbRepository {

	
	public static <T> T find(Class<T> c, int id) throws Exception {
		Transaction transaction = null;
		Session session;
		T result = null;
		try {
			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(c, id);
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return result;
	}
	
	public static <T> List<T> findAll(Class<T> c) throws Exception {
		Transaction transaction = null;
		Session session;
		List<T> resultList = null;
		try {
			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			resultList = ((List<T>) session.createSelectionQuery("From " + c.getName()).getResultList());
		} catch (Exception e) {
			throw new Exception("Error al obtener la entidad");
		}
		return resultList;
	}
	
	public static Company getCompany(String name) {
		Company result = null;
		Session session = BdUtil.getSessionFactory().openSession();

		SelectionQuery<Company> q =
				session.createSelectionQuery("From Company where name = :name", Company.class);
				q.setParameter("name", name);
				List<Company> companys = q.getResultList(); 
				if(companys.size() != 0) {
					result = companys.get(0);
				}
				session.close();
				return result;
	}
	
	public static <T> void addEntity(T t){
		Transaction transaction = null; 
		Session session = BdUtil.getSessionFactory().openSession();

		transaction = session.beginTransaction();
		try {
			session.persist(t);
			transaction.commit();
		}catch (Exception e) {
			transaction.rollback();
		}
		session.close();
	}
	
}
