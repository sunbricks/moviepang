package com.movie.pang.telck;
//		String api_key = "NCSYNVA6KW2DNSYI";
//		String api_secret = "CQMKFUGQOWAOEIFQKT5XSHWSUQWBKZXO";


import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;



public class telckService {
	public static void certifiedPhoneNumber(String tel, int code) {
		String api_key = "NCSQGXJUG9U8PZTS";
		String api_secret = "RP6BMZWWS7A9OF0IMVFXAF5GB6MU9HET";
	    Message coolsms = new Message(api_key, api_secret);

	    // 4 params(to, from, type, text) are mandatory. must be filled
	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", tel);    // 수신전화번호
	    params.put("from", "01032546661");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
	    params.put("type", "SMS");
	    params.put("text", "[TEST] 인증번호는" + "["+code+"]" + "입니다."); // 문자 내용 입력
	    params.put("app_version", "test app 1.2"); // application name and version
	    System.out.println(tel  + "0");

	    try {
	        JSONObject obj = (JSONObject) coolsms.send(params);
//	        System.out.println(obj.toString()+ randomNumber);
	      } catch (CoolsmsException e) {
//	        System.out.println(e.getMessage() + "2");
//	        System.out.println(e.getCode()  + "3");
	      }
	    
	}
	public static void giftPhoneNumber(String tel, String code, String name, String prdName) {
		String api_key = "NCSQGXJUG9U8PZTS";
		String api_secret = "RP6BMZWWS7A9OF0IMVFXAF5GB6MU9HET";
		Message coolsms = new Message(api_key, api_secret);
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", tel);    // 수신전화번호
		params.put("from", "01032546661");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS");
		params.put("text", "[무비팡]"+name+"님이"+" 보낸"+prdName+" 선물이도착했습니다" + "["+code+"]"); // 문자 내용 입력
		params.put("app_version", "test app 1.2"); // application name and version
		System.out.println(tel  + "0");
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
//	        System.out.println(obj.toString()+ randomNumber);
		} catch (CoolsmsException e) {
//	        System.out.println(e.getMessage() + "2");
//	        System.out.println(e.getCode()  + "3");
		}
		
	}
}
