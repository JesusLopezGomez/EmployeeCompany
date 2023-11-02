package com.jacaranda.model;

import java.util.Objects;

import com.jacaranda.exception.ExceptionUser;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="user")
public class User {

	@Id
	private String user;
	private String password;
	private String role;
	
	
	public User(String user, String password, String role) throws ExceptionUser {
		super();
		setUser(user);
		setPassword(password);
		this.role = role;
	}

	public User() {
		super();
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) throws ExceptionUser {
		if(user.equals("")){
			throw new ExceptionUser("Error debe introducir usuario");
		}
		this.user = user;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) throws ExceptionUser {
		if(password.equals("")){
			throw new ExceptionUser("Error debe introducir contraseña");
		}
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public int hashCode() {
		return Objects.hash(user);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return Objects.equals(user, other.user);
	}
		
}
