function generateCalendar(year, month) {
    const today = new Date();
    today.setHours(0,0,0,0); // 오늘 날짜의 시간을 00:00:00.000으로 설정

    const firstDayOfMonth = new Date(year, month - 1, 1);
    const daysInMonth = new Date(year, month, 0).getDate();

    const calendarContainer = document.getElementById('calendar');
    calendarContainer.innerHTML = ''; // 달력을 다시 그릴 때마다 초기화

    let selectedDiv; // 현재 선택된 날짜를 저장할 변수

    // 요일 정보를 나타내는 배열
    const dayOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

    // 현재 년도와 월을 표시하는 코드 추가
    const yearDiv = document.querySelector('.book_year');
    const monthDiv = document.querySelector('.book_month');
    yearDiv.textContent = `${year}`; // 현재 년도 표시
    monthDiv.textContent = `${month}`; // 현재 월 표시

    for (let day = 1; day <= daysInMonth; day++) {
        const dateDiv = document.createElement('div');
        const currentDay = new Date(year, month - 1, day);
        currentDay.setHours(0,0,0,0); // 비교 대상 날짜의 시간을 00:00:00.000으로 설정
        const dayName = dayOfWeek[currentDay.getDay()]; // 현재 날짜의 요일 이름

        // 오늘 날짜 또는 미래의 날짜에 대해서만 요일 정보와 일자 정보를 표시
        if (currentDay >= today) {
            dateDiv.textContent = `${day} ${dayName}`;

            // 일요일인 경우 글자색을 빨간색으로 설정
            if (dayName === '일') {
                dateDiv.style.color = '#FF79C2';
            }
            // 토요일인 경우 글자색을 파란색으로 설정
            else if (dayName === '토') {
                dateDiv.style.color = '#7E8CD9';
            }

            // 'clickable' 클래스 추가
            dateDiv.classList.add('clickable');
        }

        dateDiv.onclick = function() {
            if (currentDay >= today) {
                const selectedDateText = `${year}년 ${month}월 ${day}일 (${dayName})`;
                document.getElementById('selectedDate').value = selectedDateText;
                findMovScreenTime();
                // 이전에 선택된 날짜의 배경색 제거
                if (selectedDiv) {
                    selectedDiv.classList.remove('selected_date');
                }
                
                // 현재 선택된 날짜의 배경색 추가
                dateDiv.classList.add('selected_date');
                selectedDiv = dateDiv; // 현재 선택된 div 업데이트
            }
        };
        
        calendarContainer.appendChild(dateDiv);
    }
}

//window.onload = function(){
document.addEventListener('DOMContentLoaded', function () {

	// 현재 날짜 기준으로 달력 생성
    const now = new Date();
    generateCalendar(now.getFullYear(), now.getMonth() + 1);
    // 영화 목록 클릭 이벤트 처리
    var movieLists = document.querySelectorAll('.book_movie_list');
    movieLists.forEach(function(movieList) {
        movieList.addEventListener('click', function() {
        	console.log('클릭이벤트자리7777');
            // 모든 영화 목록 항목의 배경색 초기화
            movieLists.forEach(function(item) {
                item.classList.remove('selected_movie');
            });
            // 클릭된 항목에 배경색 설정
            movieList.classList.add('selected_movie');
            // 클릭된 요소에서 영화 이름 찾아 입력 필드에 설정
            var movieName = movieList.querySelector('.movie_name').textContent;
            console.log(movieName);
            document.querySelector('.movie_title input[name="tic_MovName"]').value = movieName;

            // 추가된 코드: 날짜와 상영 시간 선택 초기화
            // 모든 날짜의 선택된 상태 제거
            const calendarContainer = document.getElementById('calendar');
            const selectedDateDiv = calendarContainer.querySelector('.selected_date');
            if (selectedDateDiv) {
                selectedDateDiv.classList.remove('selected_date');
            }
            document.getElementById('selectedDate').value = ''; // 선택된 날짜 입력 필드 초기화

            // 모든 상영 시간의 선택된 상태 제거
            const screenTimes = document.querySelectorAll('.screen_time');
            screenTimes.forEach(function(screenTime) {
                screenTime.classList.remove('selected_screen');
            });
            document.getElementById('selectedTime').value = ''; // 선택된 상영 시간 입력 필드 초기화

            // 상영관 정보 입력 필드 초기화
            document.querySelector('.book_screen_info').value = '';
        });
    });
   
    

        document.addEventListener('click', function(event) {
        if (event.target.classList.contains('screen_time')) {
            var screenTimes = document.querySelectorAll('.screen_time');
            screenTimes.forEach(function(item) {
                item.classList.remove('selected_screen');
            });
            event.target.classList.add('selected_screen');
            var time = event.target.textContent;
            document.getElementById('selectedTime').value = time;
        }

        if (event.target.closest('.book_time_list')) {
            const selectedTime = event.target.closest('.book_time_list').querySelector('.screen_time').textContent;
            document.getElementById('selectedTime').value = selectedTime;
            const screenBox = event.target.closest('.screen_box');
            const screenType = screenBox.querySelector('.screen_type').textContent;
            const screenName = screenBox.querySelector('.screen_name').textContent;
            document.querySelector('.book_screen_info').value = `${screenName}(${screenType})`;
        }
    });

    // 상영 시간 선택 이벤트 리스너
    const timeListItems = document.querySelectorAll('.book_time_list');
    timeListItems.forEach(item => {
        item.addEventListener('click', function() {
            const selectedTime = this.querySelector('.screen_time').textContent;
            document.getElementById('selectedTime').value = selectedTime;

            // 상영관 정보 추출
            const screenBox = this.closest('.screen_box');
            const screenType = screenBox.querySelector('.screen_type').textContent;
            const screenName = screenBox.querySelector('.screen_name').textContent;

            // 상영관 정보를 입력 필드에 설정
            document.querySelector('.book_screen_info').value = `${screenName}(${screenType})`;

            // 필요한 경우 날짜 정보도 설정
            // document.getElementById('selectedDate').value = '선택한 날짜';
        });
    });
});