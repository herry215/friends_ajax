package com.javaex.dao;

import com.javaex.vo.GuestBook2Vo;

public class Guestbook2DaoTest {

	public static void main(String[] args) {
		
		Guestbook2Dao dao = new Guestbook2Dao();
		//System.out.println(dao.getList());
		
		//GuestBook2Vo vo = new GuestBook2Vo(1,"홍길동", "1234", "테스트", "2021-12-25");
		//dao.insert(vo);
		
		//System.out.println(dao.getList());
		
		
		GuestBook2Vo vo = new GuestBook2Vo(44," ", "1234", " ", " ");
		dao.delete(vo);
		
		System.out.println(dao.getList());
		
	}
	
}
