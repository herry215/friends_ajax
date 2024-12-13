package com.javaex.dao;

public class BookShopDaoTest {

	public static void main(String[] args) {
		
		BookShopDaoImpl dao = new BookShopDaoImpl();
		System.out.println(dao.getList().toString());
			
	}

}
