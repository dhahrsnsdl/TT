package Guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import Guest.GuestDTO;
import db.DBClose;
import utility.Utility;
import db.DBOpen;


public class GuestDAO {
	
	public boolean update(GuestDTO dto) {
		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" UPDATE	guest  ");
		sql.append(" SET    ");
		sql.append(" 	   	content = ?, ");
		sql.append(" 	   	mdate = sysdate ");
		sql.append(" WHERE ");
		sql.append("        num = ? ");

		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getNum());

			int cnt = pstmt.executeUpdate();
			
			if(cnt>0)flag=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;
	}
	
	public GuestDTO read(int num) {
		GuestDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();

		sql.append(" SELECT num, id, content, mdate");
		sql.append(" FROM guest ");
		sql.append(" WHERE num = ?");

		try {
			pstmt = con.prepareStatement(sql.toString());
			// 전송 객체 생성
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			// 쿼리문을 전송한다.
			String content = null;
			if (rs.next()) {
				dto = new GuestDTO();
				dto.setId(rs.getString("id"));
				content = rs.getString("content");
				dto.setContent(rs.getString("content"));
				dto.setMdate(rs.getString("mdate"));
				dto.setNum(rs.getInt("num"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return dto;
	}
	
	public boolean checkPasswd(String id, String chkpasswd) {

		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String passwd = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT passwd ");
		sql.append(" FROM	member ");
		sql.append(" WHERE id=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);

			rs=pstmt.executeQuery();
			if(rs.next()) {
				passwd = rs.getString(1);
			}
			if (passwd.equals(chkpasswd))flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			flag = false;
		} catch (NullPointerException e){
			// TODO Auto-generated catch block
			flag = false;
		}
		finally {
			DBClose.close(con, pstmt, rs);
		}

		return flag;
	}
	
	public boolean checkId(String id, int num) {

		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT id ");
		sql.append(" FROM	guest ");
		sql.append(" WHERE num=? ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, num);
			
			String chkid = " ";
			rs=pstmt.executeQuery();
			if(rs.next()) {
				chkid = rs.getString(1);
			}
			if (id.equals(chkid))flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			flag = false;
		} catch (NullPointerException e){
			// TODO Auto-generated catch block
			flag = false;
		}
		finally {
			DBClose.close(con, pstmt, rs);
		}

		return flag;
	}
	
	
	public boolean create(GuestDTO dto) {
	boolean flag = false;
		
	Connection con = DBOpen.open();
	PreparedStatement pstmt = null;
	
	StringBuffer sql = new StringBuffer();
	sql.append(" INSERT INTO guest(num, id, content, ipAddr, mdate)   ");
	sql.append(" VALUES			  (?,   ?,    ?,       ?,    sysdate     )     ");
	
	try {
		pstmt = con.prepareStatement(sql.toString());
		
		pstmt.setInt(1,  dto.getNum());
		pstmt.setString(2,  dto.getId());
		pstmt.setString(3,  dto.getContent());
		pstmt.setString(4,  dto.getIpAddr());
		
		int cnt = pstmt.executeUpdate();
		
		if(cnt>0) flag = true;
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} finally {
		DBClose.close(con, pstmt);
	}
	
	
	return flag;
}
	
	public int getMaxNum() {
		int result = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT NVL(MAX(num), 0) FROM guest   ");
		
		try {
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(con, pstmt, rs);
		}
			
		return result;
	}
	
	public int total(Map map) { // 맵 타입의 맵
		int total = 0;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null; // 레코드 갯수를 가져온다.(생성, 수정, 삭제하는 것이 아니기 때문에)

		String col = (String) map.get("col");
		String word = (String) map.get("word");

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT count(*) FROM guest");
		if (word.trim().length() > 0) {
			sql.append(" WHERE " + col + " like '%'||?||'%'  ");
		}

		try {
			pstmt = con.prepareStatement(sql.toString());
			if (word.trim().length() > 0) {
				pstmt.setString(1, word);
			}
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return total;
	}
	
	public List<GuestDTO> list(Map map) {
        List<GuestDTO> list = new ArrayList<GuestDTO>();
        Connection con = DBOpen.open();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
		int sno = (Integer)map.get("sno");
		int eno = (Integer)map.get("eno");
        
		StringBuffer sql = new StringBuffer();
		
		sql.append("  SELECT num, id, content, ipAddr, mdate, r ");
		sql.append("  FROM(  ");
		sql.append("  	SELECT num, id, content, ipAddr, mdate, rownum r  ");
		sql.append("  	FROM(  ");
		sql.append("	    SELECT num, id, content, ipAddr, mdate   ");
		sql.append("	 	FROM guest");
		sql.append("  		ORDER BY num DESC  ");
		sql.append("  		)  ");
		sql.append("  	)  ");
		sql.append("  WHERE r >= ? and r <= ?  ");
		
        try {
            pstmt = con.prepareStatement(sql.toString());
			int i = 1;
			pstmt.setInt(i++, sno);
			pstmt.setInt(i++, eno);
			
			rs = pstmt.executeQuery();
			
            while(rs.next())
            {
                GuestDTO dto = new GuestDTO();
                dto.setNum(rs.getInt("num"));
                dto.setId(rs.getString("id"));
                dto.setContent(rs.getString("content"));
                dto.setIpAddr(rs.getString("ipaddr"));
                dto.setMdate(rs.getString("mdate"));

                
                list.add(dto);
            }
        } catch(Exception e) {
            System.out.println(e.toString());
        } finally {
        	DBClose.close(con, pstmt, rs);
        }        
        return list;
    }
	
	 public boolean delete(int num) {
		 	boolean flag = false;
	        Connection con = DBOpen.open();
	        PreparedStatement pstmt = null;
	        
			StringBuffer sql = new StringBuffer();
			sql.append(" DELETE FROM guest  ");
			sql.append(" WHERE num = ?");
	        
	        try {
	            pstmt = con.prepareStatement(sql.toString());
	            pstmt.setInt(1, num);
	            int cnt = pstmt.executeUpdate();
	            
	            if(cnt > 0) {
	            	flag = true;
	            }
	            
	        } catch(Exception e) {
	            System.out.println(e.toString());
	        }
	        
	        return flag;
	    }
}
