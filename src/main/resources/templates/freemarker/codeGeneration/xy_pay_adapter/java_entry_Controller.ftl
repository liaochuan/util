package ${packageName}.entry;

import ${packageName}.client.constants.Constants;
import ${packageName}.client.dto.req.${tableInfo.className}ReqDTO;
import com.smarter.common.dto.request.PageReq;
import com.smarter.common.dto.request.Req;
import ${packageName}.client.dto.resp.${tableInfo.className}RespDTO;
import com.smarter.common.dto.response.PageResp;
import com.smarter.common.dto.response.Resp;
import ${packageName}.client.dto.validation.group.InsertGroup;
import ${packageName}.client.dto.validation.group.UpdateGroup;
import ${packageName}.infrastructure.service.${tableInfo.className}Service;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import io.swagger.annotations.Api;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.groups.Default;
import java.util.List;

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
    public PageResp<${tableInfo.className}RespDTO> page(@RequestBody PageReq<${tableInfo.className}ReqDTO> req) {
        return ${tableInfo.className?uncap_first}Service.page(req);
    }

    @PostMapping("/{id}")
    @ApiOperation(value = "根据id查询")
    public Resp<${tableInfo.className}RespDTO> findById(@PathVariable @ApiParam(value = "主键id") Long id) {
        return ${tableInfo.className?uncap_first}Service.findById(id);
    }

    @PostMapping("/add")
    @ApiOperation(value = "新建")
    public Resp<Boolean> add(@RequestBody @Validated({InsertGroup.class, Default.class}) Req<${tableInfo.className}ReqDTO> req) {
        return ${tableInfo.className?uncap_first}Service.add(req);
    }

    @PostMapping("/edit")
    @ApiOperation(value = "编辑")
    public Resp<Boolean> edit(@RequestBody @Validated({UpdateGroup.class, Default.class}) Req<${tableInfo.className}ReqDTO> req) {
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

}