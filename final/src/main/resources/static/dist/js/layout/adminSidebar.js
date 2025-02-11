document.addEventListener("DOMContentLoaded", function () {
    // sidebar-menu가 로드된 후에 클릭 이벤트 처리
    const sidebarMenu = document.querySelector(".sidebar-menu");

    // sidebar-menu 내의 .menu-item 클릭 이벤트 처리
    sidebarMenu.addEventListener("click", function(event) {
        // 클릭한 요소가 .menu-item일 때만 동작
        if (event.target && event.target.matches(".menu-item")) {
            console.log("클릭된 메뉴:", event.target);

            // 모든 메뉴에서 active 클래스 제거
            document.querySelectorAll(".menu-item").forEach(menu => {
                menu.classList.remove("active");
            });

            // 클릭한 메뉴에 active 클래스 추가
            event.target.classList.add("active");
            console.log("클릭된 메뉴에 active 클래스 추가:", event.target);  // 클릭된 항목 확인
        }
    });
});
