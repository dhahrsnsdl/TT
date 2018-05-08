package bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BbsTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		BbsDAO dao = new BbsDAO();
		
		total(dao);
		
		//list(dao);
		//create(dao);
		//read(dao);
		//update(dao);
		//delete(dao);
		//upViewcnt(dao);
		//passCheck(dao);
		
	}

	private static void total(BbsDAO dao) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("col", "wname");
		map.put("word", "김");
		
		int total = dao.total(map);
		
		p("레코드 갯수 : "+ total);
	}

	private static void passCheck(BbsDAO dao) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("bbsno", 3);
		map.put("passwd", "123");

		if(dao.passCheck(map)) {
			p("올바른 비번입니다.");
		}else {
			p("잘못된 비번입니다.");
		}
	}

	private static void upViewcnt(BbsDAO dao) {
		// TODO Auto-generated method stub
		BbsDTO dto = dao.read(3);
		p("조회수 : " + dto.getViewcnt());
		p("조회수가 증가됐습니다.");
		dao.upViewcnt(3);
		dto=dao.read(3);
		p("변경된 조회수 : " + dto.getViewcnt());
		
	}

	private static void delete(BbsDAO dao) {
		
		int bbsno = 4;
		
		if(dao.delete(bbsno)) {
			p("성공");
		}else {
			p("실패");
		}
		

	}

	private static void update(BbsDAO dao) {
		BbsDTO dto = dao.read(2);
				
		dto.setWname("아로민");
		dto.setTitle("제목변경");
		dto.setContent("내용변경");
		
		if(dao.update(dto)) {
			p("성공");
		}else {
			p("실패");
		}
		
	}

	private static void read(BbsDAO dao) {
		// TODO Auto-generated method stub
		int bbsno = 4;
		
		BbsDTO dto = dao.read(bbsno);
		p(dto);
	}

	private static void create(BbsDAO dao) {
		BbsDTO dto = new BbsDTO();
		
		dto.setWname("아로미");
		dto.setTitle("게시판연습");
		dto.setContent("게시판에 DB 처리 실습");
		dto.setPasswd("123");
		if(dao.create(dto )) {
			p("성공");
		}else {
			p("실패");
		}
	}

	private static void list(BbsDAO dao) {
		
		Map map = new HashMap();
		map.put("col", "wname");
		map.put("word", "");
		map.put("startno", 1);
		map.put("endno", 5);
		
		List<BbsDTO> list = dao.list(map);
		
		for(int i=0; i<list.size(); i++) {
			BbsDTO dto = list.get(i);
			p(dto);
			p("--------------------");
		}
		
	}

	private static void p(String string) {
		// TODO Auto-generated method stub
		System.out.println(string);
	}

	private static void p(BbsDTO dto) {
		// TODO Auto-generated method stub
		p("번호:" + dto.getBbsno());
		p("제목:" + dto.getTitle());
		//p("내용:" + dto.getContent());
		p("등록날짜:" + dto.getWdate());
		p("조회수:" + dto.getViewcnt());
		//p("비밀번호:" + dto.getPasswd());
		p("작성자:" +dto.getWname());
		p("grpno:" +dto.getGrpno());
		p("ansnum:" + dto.getAnsnum());
		p("indent:" + dto.getIndent());
	}
	
	

}
