package member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class memberTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		memberDAO dao = new memberDAO();
		//duplicateID(dao);
		//duplicateEmail(dao);
		//create(dao);
		//list(dao);
		//total(dao);
		//read(dao);
		//getUploadBtn(dao);
		//update(dao);
		//delete(dao);
		//loginCheck(dao);
		getgrade(dao);
	}

	
	
	private static void getgrade(memberDAO dao) {
		// TODO Auto-generated method stub
		String id = "user1";
		
		p(dao.getGrade(id));
		 
	}



	private static void loginCheck(memberDAO dao) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("id", "user1");
		map.put("pw", "1234");
		
		p("아이디 확인 : "+dao.loginCheck(map));
	}

	private static void delete(memberDAO dao) {
		// TODO Auto-generated method stub
		String id = "user4";
		
		if(dao.delete(id)) {
			p("성공");
		}else {
			p("실패");
		}
	}

	private static void getUploadBtn(memberDAO dao) {
		// TODO Auto-generated method stub
		
		p(dao.getUploadBtn("user1"));
	}

	private static void update(memberDAO dao) {
		memberDTO dto = dao.read("user1");
		//변경할 값 임의로 입력
		dto.setTel("000-0000-0000");
		dto.setZipcode("00000");
		dto.setAddress1("서울시 강남구");
		dto.setAddress2("서초동");
		dto.setEmail("user1@mail.com");
		dto.setJob("A10");
		
		if(dao.update(dto)) {
			p("성공");
		}else {
			p("실패");
		}
	}

	private static void read(memberDAO dao) {
		// TODO Auto-generated method stub
		String id  = "111111";
		
		memberDTO dto = dao.read(id);
		p(dto);
	}

	private static void total(memberDAO dao) {
		Map map = new HashMap();
		map.put("col", "mname");
		map.put("word", "user");
		
		p("레코드 개수 : "+dao.total(map));
	}

	private static void list(memberDAO dao) {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("col", "");
		map.put("word", "");
		map.put("sno", 1);
		map.put("eno", 5);
		List<memberDTO> list = dao.list(map); 
		for(int i = 0; i<list.size(); i++) {
			memberDTO dto = list.get(i);
			p(dto);
			p("-------------------------------");
		}
	}

	private static void p(memberDTO dto) {
		// TODO Auto-generated method stub
		p("아이디 :" + dto.getId());
		p("이름 :" + dto.getMname());
		p("전화번호 : " + dto.getTel());
		p("이메일 :" + dto.getEmail());
		p("우편번호 :" + dto.getZipcode());
		p("주소 :" + dto.getAddress1());
		p("상세주소 :" + dto.getAddress2());
		p("직업 :" + dto.getJob());
		p("사진명 :" + dto.getUploadBtn());
		p("등록날짜 :" + dto.getMdate());
	}

	private static void create(memberDAO dao) {
		// TODO Auto-generated method stub
		memberDTO dto = new memberDTO();
		dto.setId("test");
		dto.setPasswd("1234");
		dto.setMname("test");
		dto.setTel("test");
		dto.setEmail("test");
		dto.setZipcode("test");
		dto.setAddress1("test");
		dto.setAddress2("test");
		dto.setJob("A01");
		dto.setUploadBtn("test");
		
		if(dao.create(dto )) {
			p("성공");
		}else {
			p("실패");
		}
	}

	private static void duplicateEmail(memberDAO dao) {
		// TODO Auto-generated method stub
		String email = "  ";
		
		if(dao.duplicateEmail(email)) {
			p("중복");
		}else {
			p("사용가능");
		}
		
	}

	private static void duplicateID(memberDAO dao) {
		// TODO Auto-generated method stub
		String id = "user1111";
		
		if(dao.duplicateId(id)) {
			p("중복");
		}else {
			p("사용가능");
		}
		
		 
	}

	private static void p(String string) {
		// TODO Auto-generated method stub
		System.out.println(string);	
	}

}
