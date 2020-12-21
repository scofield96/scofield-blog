package com.scofield.blog.service;

import com.scofield.blog.entity.BlogTagCount;
import com.scofield.blog.util.PageQueryUtil;
import com.scofield.blog.util.PageResult;

import java.util.List;

public interface TagService {

    /**
     * 查询标签的分页数据
     *
     * @param pageUtil
     * @return
     */
    PageResult getBlogTagPage(PageQueryUtil pageUtil);

    int getTotalTags();

    Boolean saveTag(String tagName);

    Boolean deleteBatch(Integer[] ids);

    List<BlogTagCount> getBlogTagCountForIndex();
}
