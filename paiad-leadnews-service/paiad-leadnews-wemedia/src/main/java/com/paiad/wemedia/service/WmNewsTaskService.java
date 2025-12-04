package com.paiad.wemedia.service;

import java.util.Date;

public interface WmNewsTaskService {
    // 文章id， 发布时间
    public void addNewsToTask(Integer id, Date publishTime);

    // 消费任务，审核文章
    public void scanNewsByTask();
}
