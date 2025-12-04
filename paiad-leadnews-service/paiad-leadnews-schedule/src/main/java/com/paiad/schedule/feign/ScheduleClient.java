package com.paiad.schedule.feign;

import com.paiad.apis.schedule.IScheduleClient;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.schedule.dtos.Task;
import com.paiad.schedule.service.TaskService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "延迟任务管理", description = "延迟任务的增删查接口")
@RestController
public class ScheduleClient implements IScheduleClient {

    @Autowired
    private TaskService taskService;

    /**
     * 添加延迟任务
     *
     * @param task
     * @return
     */
    @ApiOperation(value = "添加延迟任务", notes = "添加一个新的延迟任务到调度系统")
    @PostMapping("/api/v1/task/add")
    public ResponseResult addTask(@ApiParam(value = "任务对象", required = true) @RequestBody Task task) {
        return ResponseResult.okResult(taskService.addTask(task));
    }

    /**
     * 取消任务
     *
     * @param taskId
     * @return
     */
    @ApiOperation(value = "取消任务", notes = "根据任务ID取消指定的延迟任务")
    @GetMapping("/api/v1/task/{taskId}")
    public ResponseResult cancelTask(@ApiParam(value = "任务ID", required = true) @PathVariable("taskId") long taskId){
        return ResponseResult.okResult(taskService.cancelTask(taskId));
    }

    /**
     * 按照类型和优先级拉取任务
     *
     * @param type
     * @param priority
     * @return
     */
    @ApiOperation(value = "拉取任务", notes = "按照类型和优先级从队列中拉取待执行的任务")
    @GetMapping("/api/v1/task/{type}/{priority}")
    public ResponseResult poll(
            @ApiParam(value = "任务类型", required = true) @PathVariable("type") int type,
            @ApiParam(value = "任务优先级", required = true) @PathVariable("priority") int priority) {
        return ResponseResult.okResult(taskService.poll(type,priority));
    }
}
