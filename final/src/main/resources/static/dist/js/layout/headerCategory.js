// main의 header의 카테고리 드롭다운 //
document.addEventListener("DOMContentLoaded", function () {
    let categoryBtn = document.querySelector(".category-btn"); // "전체 카테고리" 버튼
    let categoryDropdown = document.querySelector(".category-dropdown"); // 드롭다운 전체
    let categoryItems = document.querySelectorAll(".category-item"); // 개별 카테고리 항목

    // 🔹 "전체 카테고리" 버튼 클릭 시 드롭다운 열기/닫기
    categoryBtn.addEventListener("click", function (event) {
        event.stopPropagation(); // 클릭 이벤트 전파 방지
        categoryDropdown.classList.toggle("active");

        // 높이 자동 조절 (내용에 맞게)
        if (categoryDropdown.classList.contains("active")) {
            categoryDropdown.style.maxHeight = categoryDropdown.scrollHeight + "px";
        } else {
            categoryDropdown.style.maxHeight = "0px";
        }
    });

    // 🔹 개별 카테고리 클릭 시 하위 카테고리 열기/닫기
    categoryItems.forEach(item => {
        item.addEventListener("click", function (event) {
            event.preventDefault(); // 기본 링크 동작 방지
            event.stopPropagation(); // 클릭 이벤트 전파 방지
            let targetId = this.getAttribute("data-target");
            let targetSubCategory = document.getElementById(targetId);

            // 다른 열린 하위 카테고리는 닫기
            document.querySelectorAll(".sub-category").forEach(sub => {
                if (sub !== targetSubCategory) {
                    sub.style.display = "none";
                }
            });

            // 현재 클릭한 하위 카테고리를 열거나 닫기
            if (targetSubCategory.style.display === "block") {
                targetSubCategory.style.display = "none";
            } else {
                targetSubCategory.style.display = "block";
            }

            // 🔹 드롭다운 높이 자동 조정
            let openSubCategories = document.querySelectorAll(".sub-category[style='display: block;']");
            let totalHeight = 0;
            openSubCategories.forEach(sub => {
                totalHeight += sub.scrollHeight;
            });

            categoryDropdown.style.maxHeight = (totalHeight + categoryDropdown.scrollHeight) + "px";
        });
    });

    // 🔹 외부 클릭 시 드롭다운 닫기
    document.addEventListener("click", function (event) {
        if (!categoryDropdown.contains(event.target) && !categoryBtn.contains(event.target)) {
            categoryDropdown.classList.remove("active");
            categoryDropdown.style.maxHeight = "0px";
        }
    });
});

