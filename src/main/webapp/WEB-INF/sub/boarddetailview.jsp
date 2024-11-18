<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
        overflow-x: hidden; /* Prevents horizontal scrollbars from appearing */
        display: flex;
        flex-direction: column;
    }
    #board_detail_view_con {
        flex: 1; /* Allows this element to grow and fill available space */
        display: flex;
        justify-content: center;
        /* align-items: center; */
        box-sizing: border-box; /* Ensures padding is included in height calculation */
        /* overflow-x: hidden; /* Prevents horizontal scrollbars within this element */ */
    }
    .board_detail_view_con {
        width: 80%;
        max-width: 800px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        overflow-x: hidden; /* Prevents horizontal scrollbars within this element */
    }
    .board_detail_view_title input,
    .board_detail_view_date input {
        width: 100%;
        box-sizing: border-box; /* Ensures padding is included in width calculation */
        overflow-x: hidden; /* Prevents horizontal scrollbars within this element */
    }
    .board_detail_view_txt {
        width: 100%;
        flex-grow: 1; /* Allows this element to grow and fill available space */
        box-sizing: border-box; /* Ensures padding is included in width calculation */
        overflow-y: auto; /* Allows vertical scrolling if content overflows */
        overflow-x: hidden; /* Prevents horizontal scrollbars within this element */
    }
    .board_detail_view_txt div {
        width: 100%;
        height: 100%;
        padding: 10px;
        overflow-y: auto;
        overflow-x: hidden; /* Prevents horizontal scrollbars within this element */
        box-sizing: border-box;
        word-wrap: break-word; /* Allows long words to break and wrap to the next line */
    }
    .go_list_box {
        text-align: center;
        margin-top: 10px;
    }
    footer {
        text-align: center;
        padding: 10px;
        background-color: #f1f1f1;
    }
</style>
<div id="board_detail_view_con">
    <div class="board_detail_view_con pd_box inner">
        <h1 class="board_detail_page_title">공지사항</h1>
        <div class="board_detail_view_box" style="flex-grow: 1;">
            <form action="">
                <div class="board_detail_view_title">
                    <input type="text" name="bn_title" value="${Board.bn_title}" readonly>
                </div>
                <div class="board_detail_view_date">
                    <div class="board_detail_view_name">작성일</div>
                    <input type="text" name="bn_date" value="${Board.bn_date}" readonly>
                </div>
                <div class="board_detail_view_txt">
                    <div name="bn_content" id="comment" style="width: 100%; height: 100%; padding: 10px; overflow-y: auto; overflow-x: hidden; word-wrap: break-word;">
                        <c:out value="${Board.bn_content}" escapeXml="false"/>
                    </div>
                </div>
            </form>
        </div>
        <div class="go_list_box">
            <a href="/getBoardList.do">목록보기</a>
        </div>
    </div>
</div>
<%@ include file="./footer.jsp" %>