package com.jacaranda.repository;

import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.SelectionQuery;

import com.jacaranda.model.Employee;
import com.jacaranda.model.EmployeeProject;
import com.jacaranda.utiliy.BdUtil;

public class EmployeeRepository {

	public static ArrayList<EmployeeProject> getEmployeeProjects(int idEmployee) throws Exception{
		ArrayList<EmployeeProject> listEmployeeProject = null;
		Session session = null;
		try {
			session = BdUtil.getSessionFactory().openSession();
			
			SelectionQuery<EmployeeProject> queryEmployeeProject = (SelectionQuery<EmployeeProject>)
					session.createNamedQuery("select * from employeeProject where idEmployee = ?1",EmployeeProject.class);
			queryEmployeeProject.setParameter(1, idEmployee);
			listEmployeeProject = (ArrayList<EmployeeProject>) queryEmployeeProject.getResultList();
 		}catch (Exception e) {
 			session.close();
 			throw new Exception("Error al conectar a la base de datos "+ e.getMessage());
 		}
		session.close();
		return listEmployeeProject;
	}
	
	public static void delete(Employee employee) throws Exception {
		Transaction transaction = null;
		Session session;
		
		try {
			session = BdUtil.getSessionFactory().openSession();
			transaction = session.getTransaction();
		}catch (Exception e) {
			throw new Exception("Error al conectar con la base de datos " + e.getMessage());
		}
		
		try {
			ArrayList<EmployeeProject> listEmployeeProject = (ArrayList<EmployeeProject>) employee.getEmployeeProject();
			for(EmployeeProject employeeProject : listEmployeeProject) {
				session.remove(employeeProject);
			}
			session.remove(employee);
			transaction.commit();
		}catch (Exception e) {
			transaction.rollback();
			session.close();
			throw new Exception("Error al borrar el objeto " + e.getMessage());
		}
	}
	
}
