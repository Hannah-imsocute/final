package com.sp.app.service;

import com.sp.app.model.Option;

import java.util.List;

public interface OptionService {

    List<Option> getOptionList(long productCode);
}
