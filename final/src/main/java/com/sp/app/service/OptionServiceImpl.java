package com.sp.app.service;

import com.sp.app.mapper.OptionMapper;
import com.sp.app.model.Option;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j

public class OptionServiceImpl implements OptionService {
    private final OptionMapper mapper;

    @Override
    public List<Option> getOptionList(long productCode) {
        return mapper.getOptionList(productCode);
    }
}
