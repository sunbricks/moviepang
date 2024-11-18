package com.movie.view.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

public class KaKaoController {

    public enum HttpMethodType { POST, GET, DELETE }

    private final String API_SERVER_HOST  = "https://kapi.kakao.com";

    private final String USER_SIGNUP_PATH = "/v1/user/signup";
    private final String USER_UNLINK_PATH = "/v1/user/unlink";
    private final String USER_LOGOUT_PATH = "/v1/user/logout";
    private final String USER_ME_PATH = "/v1/user/me";
    private final String USER_UPDATE_PROFILE_PATH = "/v1/user/update_profile";
    private final String USER_IDS_PATH = "/v1/user/ids";

    private final String PUSH_REGISTER_PATH = "/v1/push/register";
    private final String PUSH_TOKENS_PATH = "/v1/push/tokens";
    private final String PUSH_DEREGISTER_PATH = "/v1/push/deregister";
    private final String PUSH_SEND_PATH = "/v1/push/send";

    private final ObjectMapper JACKSON_OBJECT_MAPPER = new ObjectMapper();
    private final Gson GSON = new Gson();
    private final String PROPERTIES_PARAM_NAME = "properties";

    private final List<String> adminApiPaths = new ArrayList<String>();

    {
        adminApiPaths.add(USER_IDS_PATH);
        adminApiPaths.add(PUSH_REGISTER_PATH);
        adminApiPaths.add(PUSH_TOKENS_PATH);
        adminApiPaths.add(PUSH_DEREGISTER_PATH);
        adminApiPaths.add(PUSH_SEND_PATH);
    }

    private String accessToken;
    private String adminKey;

    public void setAccessToken(final String accessToken) {
        this.accessToken = accessToken;
    }

    public void setAdminKey(final String adminKey) {
        this.adminKey = adminKey;
    }

    ///////////////////////////////////////////////////////////////
    // User Management
    ///////////////////////////////////////////////////////////////

    public String signup() {
        return request(HttpMethodType.POST, USER_SIGNUP_PATH);
    }

    public String signup(final Map<String, String> params) {
        return request(HttpMethodType.POST, USER_SIGNUP_PATH, PROPERTIES_PARAM_NAME + "=" + mapToJsonStr(params));
    }

    public String unlink() {
        return request(HttpMethodType.POST, USER_UNLINK_PATH);
    }

    public String logout() {
        return request(HttpMethodType.POST, USER_LOGOUT_PATH);
    }

    public String me() {
        return request(USER_ME_PATH);
    }

    public String updatProfile(final Map<String, String> params) {
        return request(HttpMethodType.POST, USER_UPDATE_PROFILE_PATH, PROPERTIES_PARAM_NAME + "=" + mapToJsonStr(params));
    }

    public String getUserIds() {
        return request(USER_IDS_PATH);
    }

    public String getUserIds(final Map<String, String> params) {
        return request(HttpMethodType.GET, USER_IDS_PATH, mapToParams(params));
    }


    ///////////////////////////////////////////////////////////////
    // Push Notification
    ///////////////////////////////////////////////////////////////

    public String registerPush(final Map<String, String> params) {
        return request(HttpMethodType.POST, PUSH_REGISTER_PATH, mapToParams(params));
    }

    public String getPushTokens(final Map<String, String> params) {
        return request(HttpMethodType.GET, PUSH_TOKENS_PATH, mapToParams(params));
    }

    public String deregisterPush(final Map<String, String> params) {
        return request(HttpMethodType.POST, PUSH_DEREGISTER_PATH, mapToParams(params));
    }

    public String sendPush(final Map<String, String> params) {
        return request(HttpMethodType.POST, PUSH_SEND_PATH, mapToParams(params));
    }

    public String request(final String apiPath) {
        return request(HttpMethodType.GET, apiPath, null);
    }

    public String request(final HttpMethodType httpMethod, final String apiPath) {
        return request(httpMethod, apiPath, null);
    }

    public String request(HttpMethodType httpMethod, final String apiPath, final String params) {

        String requestUrl = API_SERVER_HOST + apiPath;
        if (httpMethod == null) {
            httpMethod = HttpMethodType.GET;
        }
        if (params != null && params.length() > 0
                && (httpMethod == HttpMethodType.GET || httpMethod == HttpMethodType.DELETE)) {
            requestUrl += params;
        }

        HttpsURLConnection conn;
        OutputStreamWriter writer = null;
        BufferedReader reader = null;
        InputStreamReader isr = null;

        try {
            final URL url = new URL(requestUrl);
            conn = (HttpsURLConnection) url.openConnection();
            conn.setRequestMethod(httpMethod.toString());

            if (adminApiPaths.contains(apiPath)) {
                conn.setRequestProperty("Authorization", "KakaoAK " + this.adminKey);
            } else {
                conn.setRequestProperty("Authorization", "Bearer " + this.accessToken);
            }

            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("charset", "utf-8");
            
            //20240507_ym추가 시작
            if(requestUrl.contains("/unlink")) {
            	conn.setDoInput(true);
            	conn.setUseCaches(false);
            	conn.setDefaultUseCaches(false);
            	conn.connect();
            }
            //20240507_ym추가 종료

            if (params != null && params.length() > 0 && httpMethod == HttpMethodType.POST) {
                conn.setDoOutput(true);
                writer = new OutputStreamWriter(conn.getOutputStream());
                writer.write(params);
                writer.flush();
            }

            final int responseCode = conn.getResponseCode();
            System.out.println(String.format("\nSending '%s' request to URL : %s", httpMethod, requestUrl));
            System.out.println("Response Code : " + responseCode);
            if (responseCode == 200)
                isr = new InputStreamReader(conn.getInputStream());
            else
                isr = new InputStreamReader(conn.getErrorStream());

            reader = new BufferedReader(isr);
            final StringBuffer buffer = new StringBuffer();
            String line;
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
            System.out.println(buffer.toString());
            
            
            return buffer.toString();

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (writer != null) try { writer.close(); } catch (Exception ignore) { }
            if (reader != null) try { reader.close(); } catch (Exception ignore) { }
            if (isr != null) try { isr.close(); } catch (Exception ignore) { }
        }

        return null;
    }

    public String urlEncodeUTF8(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new UnsupportedOperationException(e);
        }
    }

    public String mapToParams(Map<String, String > map) {
        StringBuilder paramBuilder = new StringBuilder();
        for (String key : map.keySet()) {
            paramBuilder.append(paramBuilder.length() > 0 ? "&" : "");
            paramBuilder.append(String.format("%s=%s", urlEncodeUTF8(key),
                    urlEncodeUTF8(map.get(key).toString())));
        }
        return paramBuilder.toString();
    }

    public String mapToJsonStr(Map<String, String > map) {
        try {
			return JACKSON_OBJECT_MAPPER.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
         return GSON.toJson(map);
    }
}