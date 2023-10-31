package com.jacaranda.model;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Objects;

import com.jacaranda.exception.ExceptionCompanyProject;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name ="companyProject")
public class CompanyProject {
	@Id
	@ManyToOne
	@JoinColumn(name = "idCompany")
	private Company company;
	@Id
	@ManyToOne
	@JoinColumn(name = "idProject")
	private Project project;
	@Id
	private Date begin;

	private Date end;
	
	public CompanyProject(Company company, Project project, Date begin, Date end) throws ExceptionCompanyProject {
		super();
		this.company = company;
		this.project = project;
		setBegin(begin);
		setEnd(end);
	}

	public CompanyProject() {
		super();
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project idProject) {
		this.project = idProject;
	}

	public Date getBegin() {
		return begin;
	}

	public void setBegin(Date begin) throws ExceptionCompanyProject {
		if(begin.before(Date.valueOf(LocalDate.now()))) {
			throw new ExceptionCompanyProject("Error la fecha inicio debe ser despues que la fecha de hoy.");
		}
		this.begin = begin;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) throws ExceptionCompanyProject {
		if(end.before(this.begin)) {
			throw new ExceptionCompanyProject("Error la fecha final debe ser despues que la fecha inicio.");
		}
		this.end = end;
	}

	@Override
	public int hashCode() {
		return Objects.hash(begin, company, project);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CompanyProject other = (CompanyProject) obj;
		return Objects.equals(begin, other.begin) && Objects.equals(company, other.company)
				&& Objects.equals(project, other.project);
	}
	
	

}
