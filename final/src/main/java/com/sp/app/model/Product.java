package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Product {
	private long productCode;
	private long brandCode;
	private String item;
	private int price;
	private int addOptions;
	private String describe;


}
