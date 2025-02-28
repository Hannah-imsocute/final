package com.sp.app.artist.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class ShippingInfo {
    private String item_code;
    private long memberIdx;
    private String addrName;
    private String addrTitle;
    private String addrDetail;
    private String postCode;
    private String phone;
    private String require;

}
