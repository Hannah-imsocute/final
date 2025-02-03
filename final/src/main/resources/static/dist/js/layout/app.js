// 아코디언 메뉴 클릭 시 동작
document.querySelectorAll('.toggle-icon').forEach(icon => {
  icon.addEventListener('click', function(event) {
    // 클릭한 이미지의 부모 요소(a 태그)
    const button = this.closest('.accordion-button');
    const subMenu = button.nextElementSibling;  // 버튼 옆에 있는 서브 메뉴
    const isExpanded = subMenu.style.display === 'block';

    // 서브 메뉴 토글
    subMenu.style.display = isExpanded ? 'none' : 'block';

    // 아이콘 변경
    this.src = isExpanded ? '/dist/images/layout/down_∨.png' : '/dist/images/layout/up∧.png';

    // 기본 링크 클릭 동작 방지
    event.stopPropagation();
  });
});

