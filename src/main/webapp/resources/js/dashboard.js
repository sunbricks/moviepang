// Set API key and request date
const apiKey = '3b7eada3eb4d5a962c7d1d3ab93de5c6';
const yesterday = new Date();
yesterday.setDate(yesterday.getDate() - 1);
const formattedDate = yesterday.toISOString().slice(0, 10).replace(/-/g, '');

// Construct API URL
const url = `http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=${apiKey}&targetDt=${formattedDate}`;

// Send API request
fetch(url)
    .then(response => response.json())
    .then(data => {
        const boxOfficeList = data.boxOfficeResult.dailyBoxOfficeList;
    
    // Find the table body where the movie ranks will be added
    const tableBody = document.querySelector('.movie_rank_list tbody');
    
    // Clear existing rows except for the header
    while(tableBody.firstChild) {
        tableBody.removeChild(tableBody.firstChild);
        }

        // Add each movie rank and name as a new row in the table
        for (let movie of boxOfficeList) {
        const rank = movie.rank;
        const movieName = movie.movieNm;
        
        // Create a new row and cells for rank and movie name
        const row = document.createElement('tr');
        const rankCell = document.createElement('td');
        rankCell.textContent = rank;
        const nameCell = document.createElement('td');
        nameCell.textContent = movieName;
        
        // Append cells to the row, and row to the table body
        row.appendChild(rankCell);
        row.appendChild(nameCell);
        tableBody.appendChild(row);
        }
    })
.catch(error => console.error('Error:', error));



$(document).ready(function(){
    $('ul.tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#"+tab_id).addClass('current');
    })
})


$(document).ready(function(){
    $('ul.date_tabs li').click(function(){
        var tab_id = $(this).attr('data-tab');

        $('ul.date_tabs li').removeClass('plus');
        $('.date_tabs_content').removeClass('plus');

        $(this).addClass('plus');
        $("#" + tab_id).addClass('plus');

        // 해당 탭에 대한 숫자 데이터들에 대해 애니메이션 적용
        restartAnimation(tab_id);
    });
});

function restartAnimation(tab_id) {
    // 해당 탭 내의 모든 .real_value 요소에 대해 애니메이션 적용
    $("#" + tab_id + " .real_value").each(function() {
        const max = parseInt($(this).text().replace(/,/g, "")); // 쉼표 제거 후 정수 변환
        animateCounter(this, max);
    });
}

$(document).ready(function() {
    restartAnimation("day");
});

// animateCounter 함수 수정
function animateCounter(element, max) {
    let now = max;
    const handle = setInterval(() => {
        const step = now / 10;
        now -= step;

        if (now < 1) {
            clearInterval(handle);
            now = 0; // 정확한 0 처리
        }

        // 숫자 포맷팅 후 화면에 표시
        element.innerHTML = Math.ceil(max - now).toLocaleString();

    }, 50);
}

document.addEventListener("DOMContentLoaded", function() {
    // 모달 열기 기능 설정
    setupModalToggle('.movie_add_btn', '.movie_add_modal', true);
    setupModalToggle('.screen_add_btn', '.screen_add_modal', true);
    setupModalToggle('.product_add_btn', '.product_add_modal', true);
    // setupModalToggle('.annoboard_add_btn', '.add_annoboard_modal', true);
    setupModalToggle('.evboard_add_btn', '.add_evboard_modal', true);
    setupModalToggle('.pre_coupon_add_btn', '.add_pre_coupon_modal', true);
    // 모달 닫기 버튼 설정
    // 모달 닫기 버튼에 대한 클래스 이름을 추가적으로 지정해야합니다.
    // 예를 들어, '.close_member_modal'와 같이 각 모달 닫기 버튼에 대한 선택자를 사용하세요.

    setupModalClose('.close_movie_add', '.movie_add_modal');
    setupModalClose('.close_screen_add', '.screen_add_modal');
    setupModalClose('.close_product_add', '.product_add_modal');
    setupModalClose('.close_add_board_modal', '.add_annoboard_modal');
    setupModalClose('.close_add_evboard_modal', '.add_evboard_modal');
    setupModalClose('.close_add_pre_coupon_modal', '.add_pre_coupon_modal');
    setupModalClose('.close_coupon_modify_modal', '.coupon_modify_modal');
});

// 모달 열기 및 닫기 설정
function setupModalToggle(openButtonSelector, modalSelector, open = true) {
    const btnOpenModal = document.querySelector(openButtonSelector);
    const modal = document.querySelector(modalSelector);

    if (btnOpenModal && modal) {
        btnOpenModal.addEventListener("click", () => {
            modal.style.display = open ? "block" : "none";
        });
    }
}

// 모달 닫기 기능만 있는 경우
function setupModalClose(closeButtonSelector, modalSelector) {
    const btnCloseModal = document.querySelector(closeButtonSelector);
    const modal = document.querySelector(modalSelector);

    if (btnCloseModal && modal) {
        btnCloseModal.addEventListener("click", () => {
            modal.style.display = "none";
        });
    }
}


document.getElementById('movie_thumnail').addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('image_modify_preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});
// 영화 포스터 이미지 수정 미리보기

document.getElementById('add_movie_thumnail').addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('image_add_preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});
// 신규 영화 포스터 이미지 등록 미리보기


document.getElementById('product_thumnail').addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('product_modify_preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});
// 상품 이미지 수정 미리보기

document.getElementById('add_product_thumnail').addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('product_add_preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});
// 신규 상품 이미지  미리보기


document.getElementById('ev_thumnail_add_btn').addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('add_evboard_thumnail_preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});
// 이벤트 게시판 썸네일 등록 이미지 미리보기


document.getElementById('ev_thumnail_modify_btn').addEventListener('change', function(event) {
    var reader = new FileReader();
    reader.onload = function() {
        var output = document.getElementById('modify_evboard_thumnail_preview');
        output.src = reader.result;
    };
    reader.readAsDataURL(event.target.files[0]);
});
// 이벤트 게시판 썸네일 수정 이미지 미리보기





