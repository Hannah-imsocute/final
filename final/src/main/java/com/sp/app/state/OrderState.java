package com.sp.app.state;

public class OrderState {
    // 주문상태 정보
	/*
//order_state컬럼값  주문상태 : 0.입금대기 1:결제완료,2:발송처리,3:배송시작
4:배송중,5:배송완료,6.취소신청상품(작가취소),7:주문자 취소,
8.취소완료 9.교환요청,10.교환접수 11.교환 불가  12.교환 (발송)성공   13.환불요청 14.환불접수 15.환불완료 16.환불불가  17.구매확정대기 18.구매확정 19.기타
	*/
    public static final String[] ORDERSTATEINFO =
            {"입금대기", "결제완료", "발송처리", "배송시작", "배송중", "배송완료", "취소요청(작가)", "취소요청(주문자)",
                    "취소완료", "교환요청","교환접수","교환 불가","교환(발송)성공","반품요청","반품접수","반품완료","반품취소","구매확정대기","구매확정","기타"};

    // 주문상세상태 정보(관리자)
	/*
		0:구매확정대기, 1:구매확정완료, 2:자동구매확정,
		3:판매취소(관리자),
		4:주문취소요청(구매자), 5:주문취소완료(관리자),
		6:교환요청(구매자), 7:교환접수(관리자), 8:교환발송완료(관리자), 9:교환불가(관리자),
		10:반품요청(구매자), 11:반품접수(관리자), 12:반품완료(관리자), 13:반품불가(관리자), 14:기타
	*/
    public static final String[] DETAILSTATEMANAGER =
            {"구매확정대기", "구매확정완료", "자동구매확정",
                    "판매취소",
                    "주문취소요청", "주문취소완료",
                    "교환요청", "교환접수", "교환발송완료", "교환불가",
                    "반품요청","반품접수","반품완료","반품불가",
                    "기타"};

    // 주문상세상태 정보(구매자)
    public static final String[] DETAILSTATEINFOREFUNDS =
            {   "주문취소",
                    "주문취소요청", "주문취소",
                    "교환요청", "교환접수", "교환완료",
                    "반품요청","반품접수","반품완료"
            };
    public static final String[] EXCHANGEREQUEST =
            {"교환요청","교환접수","교환불가","교환완료"
            };
}
