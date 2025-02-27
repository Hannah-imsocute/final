package com.sp.app.model;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserImage {

    private String imageFileName;
    private long memberIdx;
    private MultipartFile profileFile;
}
