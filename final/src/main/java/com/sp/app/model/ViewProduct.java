package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class ViewProduct {
    private long memberIdx;
    private long productCode;
    private String item;
    private String thumbnail;
    private String viewTime;

}
