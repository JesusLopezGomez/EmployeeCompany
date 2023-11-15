package com.jacaranda.model;

import java.sql.Date;
import java.util.List;
import java.util.Objects;

import org.apache.commons.codec.digest.DigestUtils;

import com.jacaranda.exception.ExceptionUser;
import com.jacaranda.repository.EmployeeRepository;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="employee")
public class Employee {
	
	@Id
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String gender;
	private Date dateOfBirth;
	private String password;
	private String role;
	
	@ManyToOne
	@JoinColumn(name="idCompany")
	private Company company;
	
	@OneToMany(mappedBy="employee")
	private List<EmployeeProject> employeeProject;
	
	public Employee(String firstName, String lastName, String email, String gender, Date dateOfBirth,
			Company company, String password) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
		this.company = company;
		setPassword(password);
		this.role = "user";
	}
	
	public Employee() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password){
		this.password = DigestUtils.md5Hex(password);
	}

	public String getRole() {
		return role;
	}

	public void setRole(String rol) {
		this.role = rol;
	}

	public List<EmployeeProject> getEmployeeProject() throws Exception {
		return EmployeeRepository.getEmployeeProjects(this.id);
	}

	public void setEmployeeProject(List<EmployeeProject> employeeProject) {
		this.employeeProject = employeeProject;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Employee other = (Employee) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return 	String.format("Empleado id: %s, nombre: %s, apellidos: %s, email: %s, género: %s, fecha de nacimiento: %s, compañia: %s",
				getId(),getFirstName(),getLastName(),getEmail(),gender,getGender(),getCompany());

	}
	
	
	
}
