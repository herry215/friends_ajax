package com.javaex.dao;

import java.util.List;

import com.javaex.vo.GuestbookVo;

public interface GuestbookDao {
  
	public List<GuestbookVo> getList();

	public boolean insert(GuestbookVo vo);

	public boolean delete(GuestbookVo vo);

}
