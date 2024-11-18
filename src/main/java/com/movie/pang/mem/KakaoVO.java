package com.movie.pang.mem;

public class KakaoVO {
	//카카오톡에서 응답받을 url넣기(카카오톡 로그인 메뉴에 설정한 대표 리다이렉트 url넣기
	private String REDIRECT_URI = "http://moviepang.kro.kr";
	
	private String REST_API_KEY = "142032b63737157817463affb77e7777";
	private String ADMIN_KEY = "72f463baea9222bcdf951a3c39783a9a";
	private String JAVASCRIPT_KEY = "514e4ac2dbdf54db8304c95333fd10c5";
	private String CLIENT_SECRET = "IvLh51o5BAN0yu3yMUVN6kfRsl5pAGqb";
	
	//카카오톡에서 응답받을 code파라미터의 값을 받을 변수
	private String code;
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getREDIRECT_URI() {
		return REDIRECT_URI;
	}
	public void setREDIRECT_URI(String rEDIRECT_URI) {
		REDIRECT_URI = rEDIRECT_URI;
	}
	public String getREST_API_KEY() {
		return REST_API_KEY;
	}
	public void setREST_API_KEY(String rEST_API_KEY) {
		REST_API_KEY = rEST_API_KEY;
	}
	public String getADMIN_KEY() {
		return ADMIN_KEY;
	}
	public void setADMIN_KEY(String aDMIN_KEY) {
		ADMIN_KEY = aDMIN_KEY;
	}
	public String getJAVASCRIPT_KEY() {
		return JAVASCRIPT_KEY;
	}
	public void setJAVASCRIPT_KEY(String jAVASCRIPT_KEY) {
		JAVASCRIPT_KEY = jAVASCRIPT_KEY;
	}
	public String getCLIENT_SECRET() {
		return CLIENT_SECRET;
	}
	public void setCLIENT_SECRET(String cLIENT_SECRET) {
		CLIENT_SECRET = cLIENT_SECRET;
	}

}
