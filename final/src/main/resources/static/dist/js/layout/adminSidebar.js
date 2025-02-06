document.addEventListener("DOMContentLoaded", function () {
    // 🌟 기본 페이지 설정
    let defaultPage = "statsList";  // 기본 페이지 설정
    let defaultTitle = "통계 및 보고";  // 기본 페이지 제목

    // 기본 페이지 제목 설정
    document.getElementById("page-title").textContent = defaultTitle;

    // 기본 페이지 콘텐츠 숨기기 & 해당 콘텐츠 보이기
    document.querySelectorAll('[id^="main-content-"]').forEach(content => {
        content.style.display = "none";
    });

    let defaultContentId = `main-content-${defaultPage}-section`;
    let defaultContentElement = document.getElementById(defaultContentId);

    if (defaultContentElement) {
        defaultContentElement.style.display = "block";  // 기본 콘텐츠 보이기
    } else {
        console.error(`❌ Error: Element with ID '${defaultContentId}' not found.`);
        return;
    }

    // 📌 기본 페이지 fetch 요청 보내기
    fetch(`/admin/loadPage?page=${defaultPage}`)
        .then(response => {
            console.log(`📌 Fetch Response Status: ${response.status}`);
            return response.text();
        })
        .then(html => {
            console.log("📌 Loaded HTML:", html.substring(0, 100));  // HTML 일부 출력
            defaultContentElement.innerHTML = html;  // 받아온 HTML 삽입
        })
        .catch(error => console.error("❌ Error loading default page:", error));

    // ✅ 배너 클릭 이벤트 리스너 추가
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
            let pageTitle = this.textContent.trim();  // 클릭한 메뉴 제목

            console.log(`🔹 Page: ${page}, Title: ${pageTitle}`);

            // 페이지 제목 업데이트
            document.getElementById("page-title").textContent = pageTitle;

            // 모든 콘텐츠 숨기기
            document.querySelectorAll('[id^="main-content-"]').forEach(content => {
                content.style.display = "none";
            });

            let contentId = `main-content-${page}-section`;
            let contentElement = document.getElementById(contentId);

            if (contentElement) {
                contentElement.style.display = "block";
            } else {
                console.error(`❌ Error: Element with ID '${contentId}' not found.`);
                return;
            }

            // 해당 페이지의 콘텐츠 로딩
            fetch(`/admin/loadPage?page=${page}`)
                .then(response => {
                    console.log(`📌 Fetch Response Status: ${response.status}`);
                    return response.text();
                })
                .then(html => {
                    console.log("📌 Loaded HTML:", html.substring(0, 100));  // HTML 일부 출력
                    contentElement.innerHTML = html;  // 받아온 HTML 삽입
                })
                .catch(error => console.error("❌ Error loading page:", error));
        });
    });
});
