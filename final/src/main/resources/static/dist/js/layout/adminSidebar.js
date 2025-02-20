document.addEventListener("DOMContentLoaded", function () {
    const menuItems = document.querySelectorAll(".menu-item");

    // 현재 URL 경로 가져오기
    const currentPath = window.location.pathname;

    menuItems.forEach(item => {
        // 현재 페이지 URL과 메뉴의 href가 일치하면 active 클래스 추가
        if (item.getAttribute("href") === currentPath) {
            item.classList.add("active");
        }

        // 클릭 이벤트 추가
        item.addEventListener("click", function () {
            menuItems.forEach(el => el.classList.remove("active")); // 기존 active 제거
            this.classList.add("active"); // 현재 클릭한 메뉴 활성화
        });
    });
});
