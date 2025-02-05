document.addEventListener("DOMContentLoaded", function () {
    // 메뉴 항목 클릭 시
    document.querySelectorAll(".menu-item").forEach(item => {
        item.addEventListener("click", function (e) {
            e.preventDefault();

            let page = this.getAttribute("data-page");  // 클릭된 배너의 데이터 페이지 값
            let pageTitle = this.textContent;  // 클릭된 메뉴 제목

            console.log(`Page: ${page}, Title: ${pageTitle}`);  // page와 title 확인 로그

            // 페이지 제목 업데이트
            document.getElementById("page-title").textContent = pageTitle;

            // 모든 main-content 영역 숨기기
            document.querySelectorAll('[id^="main-content-"]').forEach(content => {
                content.style.display = "none";
            });

            // 클릭된 페이지 콘텐츠만 보이게 하기
            let contentId = `main-content-${page}-`;  // 'main-content-authList-'처럼 '-‘을 붙임
            let contentElement = document.getElementById(contentId);

            console.log(`Content ID: ${contentId}, Content Element: ${contentElement}`);  // contentId와 contentElement 확인

            if (contentElement) {
                contentElement.style.display = "block";
            } else {
                console.error(`Element with ID ${contentId} not found.`);
            }

            // 여기서 AJAX로 JSP 파일 로드하기
            fetch(`${contextPath}/WEB-INF/views/admin/authList.jsp`)
                .then(response => response.text())  // 응답을 텍스트로 변환
                .then(html => {
                    // 받아온 HTML을 main-content 영역에 삽입
                    document.getElementById(contentId).innerHTML = html;
                })
                .catch(error => console.error("Error loading page:", error));  // 에러 처리
        });
    });
});






/*

// 레이아웃 초기화 함수
function initializeLayout() {
    console.log("레이아웃 초기화 중...");

    // CSS 파일 동적으로 로드 (필요한 경우)
    loadStylesheet(contextPath + "/css/admin.css");  // 예시로 admin.css 파일을 로드

    // JS 초기화
    loadScripts();
}

// 동적으로 CSS 파일을 추가하는 함수
function loadStylesheet(url) {
    let link = document.createElement("link");
    link.rel = "stylesheet";
    link.href = url;
    document.head.appendChild(link);
}

// 필요한 JavaScript 파일을 동적으로 추가하는 함수
function loadScripts() {
    let script = document.createElement("script");
    script.src = contextPath + "/dist/js/layout/app.js"; // 해당 경로로 변경
    script.onload = function() {
        console.log("JavaScript 파일 로드 완료!");
        // 추가적으로 필요한 스크립트 초기화 작업
    };
    document.body.appendChild(script);
}

*/


document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".menu-item").forEach(item => {
        item.addEventListener("click", function (e) {
            e.preventDefault(); // 기본 링크 동작 방지

            // 모든 메뉴에서 active 클래스 제거
            document.querySelectorAll(".menu-item").forEach(menu => {
                menu.classList.remove("active");
            });

            // 클릭한 메뉴에 active 클래스 추가
            this.classList.add("active");

            let page = this.getAttribute("data-page"); // 클릭한 메뉴의 data-page 값 가져오기

            fetch("/WEB-INF/views/admin/" + page + ".jsp")  // JSP 파일 로드
                .then(response => response.text())
                .then(data => {
                    document.getElementById("main-content").innerHTML = data; // 내용 변경
                })
                .catch(error => console.error("Error loading page:", error));
        });
    });
});







