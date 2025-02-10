document.addEventListener("DOMContentLoaded", function () {
    // ✅ 배너 클릭 이벤트 리스너 추가
    document.querySelectorAll(".menu-item").forEach(item => {
        item.addEventListener("click", function (e) {
            // 모든 메뉴에서 active 클래스 제거
            document.querySelectorAll(".menu-item").forEach(menu => {
                menu.classList.remove("active");
            });

            // 클릭한 메뉴에 active 클래스 추가 (색 고정 효과)
            this.classList.add("active");
        });
    });
});
