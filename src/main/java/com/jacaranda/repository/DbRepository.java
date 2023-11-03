package com.jacaranda.repository;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.CompanyProject;
import com.jacaranda.model.Employee;
import com.jacaranda.utiliy.BdUtil;

public class DbRepository {

	
	public static <T> T find(Class<T> c, int id) throws Exception {
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
	
	public static <T> T find(Class<T> c, String id) throws Exception {
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
	
	public static CompanyProject find(CompanyProject cp) throws Exception {
		Session session;
		CompanyProject result = null;
		try {
			session = BdUtil.getSessionFactory().openSession();

		}catch (Exception e) {
			throw new Exception("Error en la base de datos");
		}
		
		try {
			result = session.find(CompanyProject.class,cp);
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
	
	public static <T> void editEntity(T t){
		Transaction transaction = null; 
		Session session = BdUtil.getSessionFactory().openSession();

		transaction = session.beginTransaction();
		try {
			session.merge(t);
			transaction.commit();
		}catch (Exception e) {
			transaction.rollback();
		}
		session.close();
	}
	
	public static <T> void deleteEntity(Class<T> t,int id){
		T result = null;
		Session session = BdUtil.getSessionFactory().openSession();
		Transaction transaction = null;
		
		SelectionQuery<T> q = session.createSelectionQuery("From " + t.getName() + " where id = :id",t);
		q.setParameter("id", id);
		List<T> data = q.getResultList();
		if(data.size() != 0) {
			transaction = session.beginTransaction();
			result = data.get(0);
			session.remove(result);
			transaction.commit();
		}
		session.close();
	}
	
	
}
