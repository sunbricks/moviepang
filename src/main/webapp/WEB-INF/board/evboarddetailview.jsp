<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../sub/header.jsp"%>
<div id="evboard_detail_view_con">
    <div class="evboard_detail_view_con pd_box inner">
        <h1 class="evboard_detail_page_title">이벤트</h1>
        <div class="evboard_detail_view_box">
            <form action="">
                <div class="evboard_detail_view_title">
                    <input type="text" name="ev_title" value="${Ev_board.ev_title}" readonly>
                </div>
                <div class="evboard_detail_view_date">
                    <div class="evboard_detail_view_name">진행기간</div>
                    <input type="text" name="ev_sdate" value="${Ev_board.ev_sdate}" readonly>
                    ~
                    <input type="text" name="ev_edate" value="${Ev_board.ev_edate}" readonly>
                    <div class="evboard_detail_view_name" name="ev_status">${Ev_board.ev_status}</div>
                </div>
                <div class="evboard_detail_view_txt">
                    <textarea name="ev_content" id="ev_content" cols="30" rows="20" readonly>${Ev_board.ev_content}</textarea>
                </div>
            </form>
        </div>

        <div class="go_evlist_box">
            <a href="/getEv_boardList.do">목록보기</a>
        </div>
    </div>
</div>
<%@include file="../sub/footer.jsp"%>