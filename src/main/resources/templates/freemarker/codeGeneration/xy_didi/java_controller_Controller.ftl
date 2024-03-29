package ${packageName}.controller;

import ${packageName}.api.constants.Constants;
import ${packageName}.api.dto.req.${tableInfo.className}DTO;
import ${packageName}.api.dto.req.common.PageReq;
import ${packageName}.api.dto.req.common.Req;
import ${packageName}.api.dto.resp.${tableInfo.className}VO;
import ${packageName}.api.dto.resp.common.PageResp;
import ${packageName}.api.dto.resp.common.Resp;
import ${packageName}.api.dto.validation.group.InsertGroup;
import ${packageName}.api.dto.validation.group.UpdateGroup;
import ${packageName}.service.${tableInfo.className}Service;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import io.swagger.annotations.Api;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.groups.Default;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}请求控制层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@RestController
@RequestMapping("/${tableInfo.className?uncap_first}")
@Api(tags = "${tableInfo.tableRemarks}管理")
@RequiredArgsConstructor
public class ${tableInfo.className}Controller {

    private final ${tableInfo.className}Service ${tableInfo.className?uncap_first}Service;

    @PostMapping("/page")
    @ApiOperation(value = "获取分页列表")
    public PageResp<${tableInfo.className}VO> page(@RequestBody PageReq<${tableInfo.className}DTO> req) {
        return ${tableInfo.className?uncap_first}Service.page(req);
    }

    @PostMapping("/{id}")
    @ApiOperation(value = "根据id查询")
    public Resp<${tableInfo.className}VO> findById(@PathVariable @ApiParam(value = "主键id") Long id) {
        return ${tableInfo.className?uncap_first}Service.findById(id);
    }

    @PostMapping("/add")
    @ApiOperation(value = "新建")
    public Resp<Boolean> add(@RequestBody @Validated({InsertGroup.class, Default.class}) Req<${tableInfo.className}DTO> req) {
        return ${tableInfo.className?uncap_first}Service.add(req);
    }

    @PostMapping("/edit")
    @ApiOperation(value = "编辑")
    public Resp<Boolean> edit(@RequestBody @Validated({UpdateGroup.class, Default.class}) Req<${tableInfo.className}DTO> req) {
        return ${tableInfo.className?uncap_first}Service.edit(req);
    }

    @PostMapping("/enable")
    @ApiOperation(value = "启用")
    public Resp<Boolean> enable(@RequestBody @ApiParam(value = "主键id列表") Req<List<Long>> req) {
        return ${tableInfo.className?uncap_first}Service.updateStateByIds(req.getData(), Constants.ENABLE);
    }

    @PostMapping("/disable")
    @ApiOperation(value = "禁用")
    public Resp<Boolean> disable(@RequestBody @ApiParam(value = "主键id列表") Req<List<Long>> req) {
        return ${tableInfo.className?uncap_first}Service.updateStateByIds(req.getData(), Constants.DISABLE);
    }

    @PostMapping("/delete")
    @ApiOperation(value = "删除")
    public Resp<Boolean> delete(@RequestBody @ApiParam(value = "主键id列表") Req<List<Long>> req) {
        return webPageGroupService.delete(req.getData());
    }

}