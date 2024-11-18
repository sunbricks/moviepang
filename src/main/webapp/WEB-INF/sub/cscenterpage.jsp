<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="cscenter_con">
    <div class="cscenter_con pd_box inner">
        <ul class="cscenter_tabs">
            <li class="tab-link add" data-tab="announceboard">공지사항</li>
            <li class="tab-link" data-tab="faq">자주 묻는 질문</li>
            <li class="tab-link" data-tab="tou">이용 약관</li>
        </ul>

        <div id="announceboard" class="tab-content add">
        
            <div class="cs_top_con">
                <h1 class="cscenter_title">공지사항</h1>
            </div>
            <div class="board_list_box">
                <table>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${boardList}" var="board" varStatus="status">
                     <tr onclick="selTr(${board.bn_num})" style="cursor: pointer;">
                     <%-- <td class="tdCenter">${status.index + 1}</td> --%>
                     <td class="tdCenter">${board.bn_num}</td>
                     <td>${board.bn_title}</td>
<%--                      <td class="tdCenter">${board.bn_type}</td> --%>
                     <td class="tdCenter">${board.bn_date}</td>
                     </tr>
                  </c:forEach>
                    </tbody>
                </table>
                <div id="pageBtnParentDiv">
         <c:if test="${pi.currentPage > 1}">
            <button class="pageBtn" type="button"
               onclick="location.href='getBoardList.do?currentPage=${pi.currentPage - 1}';">이전</button>
         </c:if>

         <c:choose>
            <c:when test="${pi.maxPage <= 3}">
               <c:forEach var="i" begin="1" end="${pi.maxPage}" step="1">
                  <button class="pageBtn" type="button"
                     onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
               </c:forEach>
            </c:when>
            <c:otherwise>
               <c:choose>
                  <c:when test="${pi.currentPage <= 2}">
                     <c:forEach var="i" begin="1" end="3" step="1">
                        <button class="pageBtn" type="button"
                           onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
                     </c:forEach>
                  </c:when>
                  <c:when test="${pi.currentPage > pi.maxPage - 2}">
                     <c:forEach var="i" begin="${pi.maxPage - 2}" end="${pi.maxPage}"
                        step="1">
                        <button class="pageBtn" type="button"
                           onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
                     </c:forEach>
                  </c:when>
                  <c:otherwise>
                     <c:forEach var="i" begin="${pi.currentPage - 1}"
                        end="${pi.currentPage + 1}" step="1">
                        <button class="pageBtn" type="button"
                           onclick="location.href='getBoardList.do?currentPage=${i}';">${i }</button>
                     </c:forEach>
                  </c:otherwise>
               </c:choose>
            </c:otherwise>
         </c:choose>

         <c:if test="${pi.currentPage < pi.maxPage}">
            <button class="pageBtn" type="button"
               onclick="location.href='getBoardList.do?currentPage=${pi.currentPage + 1}';">다음</button>
         </c:if>
      			</div>
            </div>
        </div>
        <style>
#pageBtnParentDiv {
   text-align: center;
   margin-top: 20px;
}

button.pageBtn {
   margin-right: 20px;
   padding: 5px 15px;
   background-color: #000;
   color: #fff;
   border: none;
   cursor: pointer;
}

button.pageBtn:focus{
	background-color: red;
}
</style>

        

        <div id="faq" class="tab-content">
                <div class="cs_top_con">
                    <h1 class="cscenter_title">자주 묻는 질문</h1>
                </div>
                <div class="faq_box">
                    <ul class="inc_acodian">
                        <li class="acodian_list">
                            <div class="info_box quest_box">
                                <div class="quest_mark">
                                    <span>Q</span> </div>
                                <div class="quest_info">무비팡의 좌석수는 몇 좌석 입니까?</div>
                            </div>
                            <ul class="info_text answer_box">
                                <li>
                                    <div class="info_box">
                                        <div class="answer_mark">
                                            <span>A</span></div>
                                        <div class="answer_info">
                                            무비팡은 상영관당 100좌석입니다.
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </li>

                        <li class="acodian_list">
                            <div class="info_box quest_box">
                                <div class="quest_mark">
                                    <span>Q</span> </div>
                                <div class="quest_info">상영관 입장은 언제부터 가능한가요?</div>
                            </div>
                            <ul class="info_text">
                                <li>
                                    <div class="info_box answer_box">
                                        <div class="answer_mark">
                                            <span>A</span></div>
                                        <div class="answer_info">영화 시작 시간 15분 전부터 입장 가능합니다. </div>
                                    </div>
                                </li>
                            </ul>
                        </li>

                        <li class="acodian_list">
                            <div class="info_box quest_box">
                                <div class="quest_mark">
                                    <span>Q</span> </div>
                                <div class="quest_info">영유아는 몇살부터 입장 가능한가요</div>
                            </div>
                            <ul class="info_text">
                                <li>
                                    <div class="info_box answer_box">
                                        <div class="answer_mark">
                                            <span>A</span></div>
                                        <div class="answer_info">[전체 관람가]를 제외한 등급의 영화 상영관에는 4세 미만의 영유아 어린이의 입장을 제한하고 있습니다.</div>
                                    </div>
                                </li>
                            </ul>
                        </li>

                        <li class="acodian_list">
                            <div class="info_box quest_box">
                                <div class="quest_mark">
                                    Q </div>
                                <div class="quest_info">무비팡은 어디에 위치해 있나요?</div>
                            </div>
                            <ul class="info_text">
                                <li>
                                    <div class="info_box answer_box">
                                        <div class="answer_mark">
                                            <span>A</span></div>
                                        <div class="answer_info">무비팡은 안양역에 위치해 있습니다.</div>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>                              
                </div>
                <script>
                    $('.info_text').hide();
                        $('.inc_acodian > .acodian_list').click(function() {
                            if ( $(this).hasClass('active') ) {
                                $(this).find('.info_text').stop().slideUp(500);
                                $(this).removeClass('active');
                            }
                            else {
                                $(this).find('.info_text').stop().slideDown(500);
                                $(this).addClass('active');
                        }
                    });
                        // incruit acodian event
                </script>
            </div>

            <div id="tou" class="tab-content">
                <div class="cs_top_con">
                    <h1 class="cscenter_title">이용 약관</h1>
                </div>
                <div class="text_box">
                    제1조. 목적
이 약관은 태안문화원(이하 '회사'라 합니다)이 제공하는 온라인, 오프라인 서비스(이하 "서비스"라 합니다) 이용과 관련하여 회사와 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.

제 2조. 약관의 효력 및 변경
1.이 약관은 서비스를 통하여 이를 공지함으로써 효력이 발생됩니다.
2.회사는 사정상 중요한 사유가 발생될 경우 사전 고지 없이 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 서비스를 통하여 공지합니다.
3.회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴를 요청할 수 있으며, 변경된 약관의 효력 발생일 이후 해지 요청을 하지 않을 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.

제3조. 약관 외 준칙
본 약관에 명시되지 아니한 사항에 대해서는 전기통신기본법, 전기통신사업법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 및 기타 관련 법령의 규정에 따릅니다.

제 4조. 용어의 정의
이 약관에서 사용하는 주요한 용어의 정의는 다음과 같습니다.
1."회원" : 이 약관을 인지하고, 회사에 개인정보를 제공하여 회원으로서 등록하여 이용자 아이디(ID)를 부여 받은 자로서, 회사의 정보를 지속적으로 제공 받으며, 회원혜택을 받는 분을 말합니다.
2."아이디" : 회원의 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 영문이나 숫자 혹은 그 조합을 말합니다(이하"ID"라 합니다).
3."비밀번호" : 회원이 부여 받은 ID와 일치된 회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.
4."서비스" : 회사가 회원을 위하여 유료 또는 무료로 제공하는 행위 또는 그 행위 대상인 유,무형의 물건 자체를 의미합니다.
5."이용중지" : 회사가 약관에 의거하여 회원의 서비스 이용을 제한하는 것을 말합니다.
6."해지" : 회사 또는 회원이 서비스 사용 후 이용계약을 해약하는 것을 말합니다.

제 5조. 이용 계약의 성립
1.서비스 가입 신청 시 본 약관을 읽고 "동의함" 버튼을 클릭하면 본 약관에 동의하는 것으로 간주됩니다.
2.이용약관은 서비스 이용희망자의 이용약관 동의 후 이용 신청에 대하여 회사가 승낙함으로써 성립하며, 이용 신청 및 회사의 승낙에 대해서는 본 약관 제6조 및 제7조에서 규정된 바에 따릅니다.
3.“정보통신망이용촉진및정보보호등에관한법률”상 만14세 미만의 아동은 온라인으로 타인에게 개인정보를 보내기 전에 반드시 개인정보의 수집 및 이용목적에 대하여 충분히 숙지하고 법정대리인(부모)의 동의를 받아야 합니다.

제6조. 이용신청회원으로 가입하여 서비스를 이용하기를 희망하는 자는 회사가 정한 소정 양식에 따라 요청하는 개인인적사항을 제공하여 이용신청을 합니다.

제 7조. 이용 신청의 승낙
1.회사는 제 6 조에 따른 이용신청에 대하여 특별한 사정이 없는 한 접수 순서대로 이용 신청을 승낙합니다.
2.회사는 다음 각 호에 해당하는 경우 이용신청에 대한 승낙을 제한할 수 있고, 그 사유가 해소될 때까지 승낙을 유보할 수 있습니다.
1) 서비스 관련 설비에 여유가 없는 경우
2) 기술상 지장이 있는 경우
3) 기타 회사의 사정상 필요하다고 인정되는 경우
3.회사는 다음 각 호에 해당하는 사항을 인지하는 경우 동 이용계약 신청을 승낙하지 아니할 수 있습니다. 1) 본인의 실명으로 신청하지 않은 경우
2) 다른 사람의 명의를 사용하여 신청한 경우
3) 이용 신청 시 필요 사항을 허위로 기재하여 신청한 경우
4) 사회의 안녕과 질서 혹은 미풍양속을 저해할 목적으로 신청한 경우
5) 기타 회사가 정한 이용 신청 요건이 미비 된 경우
4.제 2 항 또는 3 항에 의하여 이용신청의 승낙을 유보하거나 승낙하지 아니하는 경우, 회사는 이를 이용신청자에게 알려야 합니다. 다만, 회사의 귀책사유 없이 이용신청자에게 통지할 수 없는 경우는 예외로 합니다.

제 8조. 개인정보의 보호
1.회사는 회원의 개인정보를 보호하고 존중합니다.
2.회사는 이용신청 시 회원이 제공하는 정보, 커뮤니티 활동, 각종 이벤트 참가를 위하여 회원이 제공하는 정보, 기타 서비스 이용 과정에서 수집되는 정보 등을 통하여 회원에 관한 정보를 수집하며, 회원의 개인정보는 본 이용계약의 이행과 본 이용계약상의 서비스 제공을 위한 목적으로 사용됩니다.
3.회사는 서비스 제공과 관련하여 취득한 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 다음의 각 호에 해당하는 경우에는 그러하지 아니합니다. 1) 정보통신서비스의 제공에 따른 요금 정산을 위하여 필요한 경우
2) 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우
3) 관계 법령에 의하여 수사상 목적으로 정해진 절차와 방법에 따라 관계기관의 요구가 있는 경우
4) 다른 법률에 특별한 규정이 있는 경우
5) 정보통신윤리위원회가 관계법령에 의하여 요청 경우
4.제 3 항의 범위 내에서 회사는 업무와 관련하여 회원 전체 또는 일부의 개인정보에 관한 집합적인 통계 자료를 작성하여 이를 사용할 수 있고, 서비스를 통하여 회원의 컴퓨터에 쿠키를 전송할 수 있습니다. 이 경우 회원은 쿠키의 수신을 거부하거나 쿠키의 수신에 대하여 경고하도록 사용하는 컴퓨터의 브라우저의 설정을 변경할 수 있습니다..
5.회원이 가입 시 제공한 정보는 회원 가입 시점부터 해지 완료 후 30일까지 보관할 수 있습니다. 법령의 규정에 의하여 보존할 필요성이 있는 경우에는 예외로 합니다.
6.정보통신망 이용촉진 및 정보보호 등에 관한 법률에 따라 1년 이상 멤버십 서비스를 이용하지 않아 휴면계정으로 전환 된 경우 회원 정보를 별도 분리보관하여 관리하며, 휴면 계정으로 전환된 후에도 1년동안 메가박스 미이용시 회원 계정 및 개인정보는 파기됩니다. 개인정보 파기시에는 보유중인 멤버십 포인트, 쿠폰, 관람권 등이 삭제 처리 됩니다.
7.휴면계정으로 전환된 회원의 경우 휴면 기간 동안 로그인 및 포인트 적립 및 사용 등 메가박스에서 제공하는 모든 서비스를 받을 수 없으며, 별도의 본인 인증 절차를 통해 휴면 계정에서 활동 계정으로 변경 시 지속적인 서비스를 받으실 수 있습니다.

제 9조. 개인정보의 이용
1.회사가 수집하는 개인정보는 서비스의 제공에 필요한 최소한으로 하되, 필요한 경우 보다 더 자세한 정보를 요구할 수 있습니다.
2.회사는 다음의 각 호와 같은 경우에는 이용자의 동의 하에 개인정보를 제3자에게 제공할 수 있습니다. 이러한 경우에도 개인정보의 제3자 제공은 이용자의 동의 하에서만 이루어지며 개인정보가 제공되는 것을 원하지 않는 경우에는, 특정 서비스를 이용하지 않거나 특정한 형태의 판촉이나 이벤트에 참여하지 않으면 됩니다. 1) 메가박스 사이트 유료 컨텐트 이용, 쇼핑몰에서의 물품구매 등 서비스 제공을 위해 이용자의 이름, 주소, 전화번호 등이 해당 유료 컨텐트 제공자, 쇼핑몰 업체, 배송업자에게 제공될 수 있습니다.
2) 메가박스 사이트 내에서 벌어지는 각종 이벤트 행사에 참여한 회원의 개인정보가 해당 이벤트의 주최자에게 제공될 수 있습니다.
3.회사가 외부업체(이하 위탁 받는 업체)에 특정서비스의 제공을 위탁하는 경우 서비스 제공에 필요한 회원의 개인정보를 회원의 동의를 받아 위탁 받는 업체에 제공할 수 있으며 서비스 위탁 사실을 명시 합니다. 단, 관련 법령에 따라 개인정보 처리방침을 통해 고지할 경우 개별적인 고지절차와 동의절차를 거치지 아니할 수 있습니다. 위탁 받는 업체는 제공받은 회원의 개인정보의 수집, 취급, 관리에 있어 위탁 받은 목적 외의 용도로 이를 이용하거나 제3자에게 제공하지 않습니다.
4.회사는 회사가 제공하는 서비스를 이용하는 이용자를 대상으로 해당 서비스의 양적, 질적 향상을 위하여 이용자의 개인 식별이 가능한 개인정보를 이용자의 동의를 받아 이를 수집하여 맞춤서비스, 온라인광고서비스, 쇼핑몰서비스, 커뮤니티서비스, 유료컨텐츠서비스, 모바일서비스, 콜센터를 통한 보험, 신용카드 등의 텔레마케팅서비스 등에 이용할 수 있습니다.
5.회사는 회원에게 제공되는 서비스의 질을 향상시키기 위해 맞춤서비스, 온라인광고서비스, 쇼핑몰서비스, 커뮤니티서비스, 유료컨텐츠서비스, 모바일서비스, 보험, 신용카드 등의 텔레마케팅서비스, 통계작성 또는 시장조사 등 다양한 서비스를 제공할 목적으로 여러 분야의 전문 컨텐츠 사업자 혹은 비즈니스 사업자와 함께 파트너쉽을 맺을 수 있습니다.
6.회사는 5항의 파트너쉽을 맺은 제휴사와 회원의 개인정보를 제공, 공유할 경우 반드시 이용자의 동의를 받아 필요한 최소한의 정보를 제휴사에게 제공, 공유하며 이때 누구에게 어떤 목적으로 어떠한 정보(제휴사명, 제휴의 목적, 공유하는 개인정보)를 공유하는지 명시합니다.
7.동조 3항 ~ 6항의 개인정보 이용 시 이용자의 동의는 별도의 공지사항 등을 통하여 공지하는 방법으로 받아낼 수 있습니다.
8.회원은 원하는 경우 언제든 회사에 제공한 개인정보의 수집과 이용에 대한 동의를 철회할 수 있으며, 동의의 철회는 해지 신청을 하는 것으로 이루어집니다.

제 10조.
계약사항의 변경1.회원은 개인정보관리를 통해 언제든지 본인의 개인정보를 열람하고 수정할 수 있습니다.
2.회원은 이용신청 시 기재한 사항이 변경되었을 경우 온라인으로 수정을 해야 하며 회원정보를 변경하지 아니하여 발생되는 문제의 책임은 회원에게 있습니다.
3.회원이 원하는 경우 이용동의를 철회할 수 있으며, 이용동의를 철회한 경우 서비스 이용이 제한됩니다. 이용 동의의 철회는 해지 신청을 하는 것으로 이루어집니다.

제 11조. 회사의 의무1.회사는 이 약관에서 정한 바에 따라 계속적이고 안정적인 서비스의 제공을 위하여 지속적으로 노력하며, 설비에 장애가 생기거나 멸실 된 때에는 지체 없이 이를 수리 복구하여야 합니다. 다만, 천재지변, 비상사태 또는 그 밖에 부득이한 경우에는 그 서비스를 일시 중단하거나 중지할 수 있습니다.
2.회사는 회원으로부터 소정의 절차에 의해 제기되는 의견이나 불만이 정당하다고 인정할 경우에는 적절한 절차를 거처 처리하여야 합니다. 처리 시 일정 기간이 소요될 경우 회원에게 그 사유와 처리 일정을 알려주어야 합니다.
3.회사는 회원의 프라이버시 보호와 관련하여 제 8 조에 제시된 내용을 지킵니다.
4.회사는 이용계약의 체결, 계약사항의 변경 및 해지 등 이용고객과의 계약 관련 절차 및 내용 등에 있어 이용고객에게 편의를 제공하도록 노력합니다.

제 12조. 회원의 의무
1.회원은 이 약관에서 규정하는 사항과 이용안내 또는 공지사항 등을 통하여 회사가 공지하는 사항을 준수하여야 하며, 기타 회사의 업무에 방해되는 행위를 하여서는 안됩니다.
2.회원의 ID와 비밀번호에 관한 모든 관리책임은 회원에게 있습니다. 회원에게 부여된 ID와 비밀번호의 관리 소홀, 부정 사용에 의하여 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.
3.회원은 자신의 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 회사에 신고하여야 하며, 신고를 하지 않아 발생하는 모든 결과에 대한 책임은 회원에게 있습니다.
4.회원은 회사의 사전승낙 없이는 서비스를 이용하여 영업활동을 할 수 없으며, 그 영업활동의 결과와 회원이 약관에 위반한 영업활동을 하여 발생한 결과에 대하여 회사는 책임을 지지 않습니다. 회원은 이와 같은 영업활동으로 회사가 손해를 입은 경우 회원은 회사에 대하여 손해배상의무를 집니다.
5.회원은 회사의 명시적인 동의가 없는 한 서비스의 이용권한, 기타 이용 계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.
6.회원은 서비스 이용과 관련하여 다음 각 호에 해당되는 행위를 하여서는 안됩니다. 1) 다른 회원의 ID와 비밀번호, 주민등록번호 등을 도용하는 행위
2) 본 서비스를 통하여 얻은 정보를 회사의 사전승낙 없이 회원의 이용 이외 목적으로 복제하거나 이를 출판 및 방송 등에 사용하거나 제3자에게 제공하는 행위
3) 본인의 특허, 상표, 영업비밀, 저작권 기타 지적재산권을 침해하는 내용을 게시, 전자메일 또는 기타의 방법으로 타인에게 유포하는 행위
4) 공공질서 및 미풍양속에 위반되는 저속, 음란한 내용의 정보, 문장, 도형 등을 전송, 게시, 전자메일 또는 기타의 방법으로 타인에게 유포하는 행위
5) 모욕적이거나 위협적이어서 타인의 프라이버시를 침해할 수 있는 내용을 전송, 게시, 전자메일 또는 기타의 방법으로 타인에게 유포하는 행위
6) 범죄와 결부된다고 객관적으로 판단되는 행위
7) 회사의 승인을 받지 않고 다른 사용자의 개인정보를 수집 또는 저장하는 행위
8) 기타 관계법령에 위배되는 행위

제 13조. 회원의 특전1.멤버십 카드를 발급 받은 회원은 홈페이지 회원 로그인을 통한 티켓 구매 시 또는 전국 영화관 현장에서 티켓을 구매하면서 멤버십 카드를 제시한 경우, 구매한 영화 티켓 금액의 10%에 해당되는 멤버십 포인트를 회원 본인의 계정에 적립할 수 있습니다. 멤버십 포인트의 적립은 티켓의 유료 구매 시만 가능하며, 영화 상영 시작 시각 이후 사후 적립은 불가능합니다. 멤버십 포인트는 상영일 익일에 적립되고, 적립된 멤버십 포인트 내역은 영화관람 익일에 확인할 수 있습니다. 극장 내 매점 이용에 대해서는 멤버십 포인트가 적립되지 않습니다.
2.회원은 티켓을 구입할 때 멤버십 카드를 제시하거나 회원을 식별할 수 있는 정보를 제공하여야만 적립이 가능하며, 단체관람을 통해 할인을 받을 경우 포인트는 적립되지 않습니다.
3.온라인 예매는 1회 8매까지로 한정하며, 구매 횟수는 1일 10회로 제한됩니다. 단, 현장 구매 시에는 매수를 제한하지 않습니다.
4.회원은 회사가 사전 공지한 행사 및 이벤트의 참여를 통해 멤버십 포인트를 추가로 적립 받을 수 있습니다. 이 경우 적립되는 멤버십 포인트는 행사 공지 시 별도로 공지된 기준에 따라 적립되며, 이벤트 포인트는 VIP 선정기준에 제외됩니다.
5.회원은 본인의 계정으로 적립된 멤버십 포인트를 타인에게 양도하거나 타인의 멤버십 포인트와 합산할 수 없습니다.
6.이미 구매한 영화 티켓을 환불할 경우, 해당 멤버십 포인트는 적립 취소됩니다.
7.멤버십 포인트는 최초 적립된 시점에서 24개월이 지난 시점의 해당 월 말일에 먼저 적립된 포인트부터 월 단위로 자동 소멸됩니다. 당사는 회원에게 제공되는 포인트의 소멸시효가 도래하여 포인트를 소멸시키는 경우, 포인트 소멸과 관련된 내용을 최소 15일 전 e-mail 또는 SMS를 발송하여 홈페이지에서 해당월 소멸 예정 포인트 확인이 가능하도록 조치 합니다.

부칙1.
(시행일) 이 약관은 2016년 3월 3일부터 시행합니다.
2.(변경) 종전의 약관은 본 약관으로 대체합니다.
                </div>
            </div>

    </div>
</div>
<%@include file="./footer.jsp"%>