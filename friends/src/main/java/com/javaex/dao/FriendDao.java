package com.javaex.dao;


import com.javaex.vo.FriendVo;

import java.util.List;

public interface FriendDao {

    public List<FriendVo> getList();

    public int insert(FriendVo vo);

    public int delete(String ids);

    public int update(FriendVo vo);

    public boolean selectFriendByEmail(String email);

    public boolean selectFriendByPhone(String phone);

}
