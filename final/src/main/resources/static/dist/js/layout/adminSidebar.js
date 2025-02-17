$(document).ready(function() {
    $('.sidebar-menu .menu-item').on('click', function() {
        // 모든 메뉴 항목에서 'active' 클래스를 제거
        $('.sidebar-menu .menu-item').removeClass('active');
        
        // 클릭한 메뉴 항목에 'active' 클래스 추가
        $(this).addClass('active');
    });
});
