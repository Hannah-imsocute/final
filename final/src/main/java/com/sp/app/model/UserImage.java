package com.sp.app.model;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserImage {

    private String imageFileName;
    private long memberIdx;


}
