package com.sp.app.model;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Ask {
    private long askNum; // 기본키
    private long memberIdx;
    private long productCode; // 상품코드
    private String productName; // 상품이름
    private String subject;
    private String content;
    private String askDate; // 문의날짜
    private int answerState; // 답변유무
    private String answerContent; // 답변내용
    private String answerDate; // 답변날짜
    private int category; // 카테고리 코드
    private String brandName;
}

/*
ask_num         NUMBER          NOT NULL,
memberIdx       NUMBER          NOT NULL,
ProductCode     NUMBER          NOT NULL,
subject         VARCHAR2(100)   NOT NULL,
content         VARCHAR2(4000)  NOT NULL,
category        NUMBER          NOT NULL,
answer_state    NUMBER(1)       DEFAULT 0 NOT NULL,     -- 답변 여부 (0: 미답변, 1: 답변 완료)
answer_content  VARCHAR2(4000)  NULL,
answer_date     DATE            NULL,
*/
