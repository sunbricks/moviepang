$(document).ready(function(){
    $('ul.event_tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.event_tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
    })
    
    // 고객센터의 탭 메뉴
    $('ul.cscenter_tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.cscenter_tabs li').removeClass('add');
        $('.tab-content').removeClass('add');

        $(this).addClass('add');
        $("#"+tab_id).addClass('add');
    })
    
    $('ul.movie_list_tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.movie_list_tabs li').removeClass('on');
        $('.movie_list_content').removeClass('on');

        $(this).addClass('on');
        $("#"+tab_id).addClass('on');
    })
    
    $('ul.mypage_tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.mypage_tabs li').removeClass('add');
        $('.mypage-content').removeClass('add');

        $(this).addClass('add');
        $("#"+tab_id).addClass('add');
    })
})

window.onload = function() {
    var basicPayment = document.getElementById('basicPayment');
    var pointPayment = document.getElementById('pointPayment');

    var basicPaymentBox = document.querySelector('.basicPayment_box');
    var pointPaymentBox = document.querySelector('.pointPayment_box');

    // 페이지 로딩시 기본적으로 basicPaymentBox만 보이게 설정
    basicPaymentBox.style.display = 'block';
    pointPaymentBox.style.display = 'none';

    basicPayment.addEventListener('change', function() {
        // basicPayment 선택시 basicPaymentBox 보이기
        basicPaymentBox.style.display = 'block';
        pointPaymentBox.style.display = 'none';
    });

    pointPayment.addEventListener('change', function() {
        // pointPayment 선택시 pointPaymentBox 보이기
        basicPaymentBox.style.display = 'none';
        pointPaymentBox.style.display = 'block';
    });
}

$('.review_txt_box textarea').keyup(function(){
    var content = $(this).val();
    $('.review_txt_box .str_cnt span').html(content.length);
    if (content.length > 100){
        alert("최대 200자까지 입력 가능합니다.");
        $(this).val(content.substring(0, 200));
        $('.review_txt_box .str_cnt span').html(200);
    }
});

