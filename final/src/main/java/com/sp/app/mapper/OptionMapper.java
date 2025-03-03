package com.sp.app.mapper;

import com.sp.app.model.Option;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OptionMapper {
    List<Option> getOptionList(long productCode);

}
