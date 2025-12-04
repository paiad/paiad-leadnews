package com.paiad.wemedia.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.paiad.apis.schedule.IScheduleClient;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.common.enums.TaskTypeEnum;
import com.paiad.model.schedule.dtos.Task;
import com.paiad.model.wemedia.pojos.WmNews;
import com.paiad.utils.common.ProtostuffUtil;
import com.paiad.wemedia.service.WmNewsAutoScanService;
import com.paiad.wemedia.service.WmNewsTaskService;
import io.protostuff.ProtostuffOutput;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
@Slf4j
public class WmNewsTaskServiceImpl implements WmNewsTaskService {
    @Autowired
    private IScheduleClient scheduleClient;
    @Override
    @Async
    public void addNewsToTask(Integer id, Date publishTime) {
        log.info("添加任务到延迟服务中---begin");
        Task task = new Task();
        task.setExecuteTime(publishTime.getTime());
        task.setTaskType(TaskTypeEnum.NEWS_SCAN_TIME.getTaskType());
        task.setPriority(TaskTypeEnum.NEWS_SCAN_TIME.getPriority());
        WmNews wmNews = new WmNews();
        wmNews.setId(id);
        task.setParameters(ProtostuffUtil.serialize(wmNews));

        scheduleClient.addTask(task);
        log.info("添加任务到延迟服务中---end");
    }

    @Autowired
    private WmNewsAutoScanService wmNewsAutoScanService;
    //审核文章
    @Override
    @Scheduled(fixedRate = 5 * 60 * 1000)// 5min
    public void scanNewsByTask() {
        log.info("消费任务，审核文章");
        ResponseResult responseResult = scheduleClient.poll(TaskTypeEnum.NEWS_SCAN_TIME.getTaskType(), TaskTypeEnum.NEWS_SCAN_TIME.getPriority());
        if(responseResult.getCode().equals(200) && responseResult.getData() != null){
            Task task = JSON.parseObject(JSON.toJSONString(responseResult.getData()), Task.class);
            WmNews wmnews = ProtostuffUtil.deserialize(task.getParameters(), WmNews.class);
            wmNewsAutoScanService.autoScanWmNews(wmnews.getId());
        }
    }
}
