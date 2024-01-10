package ${packageName}.controller;

import com.xy.ad.common.api.constant.Constants;
import ${packageName}.api.dto.req.${tableInfo.className}DTO;
import com.xy.ad.common.api.dto.req.PageReq;
import com.xy.ad.common.api.dto.req.Req;
import ${packageName}.api.dto.resp.${tableInfo.className}VO;
import com.xy.ad.common.api.dto.resp.PageResp;
import com.xy.ad.common.api.dto.resp.Resp;
import com.xy.ad.common.api.dto.validation.group.InsertGroup;
import com.xy.ad.common.api.dto.validation.group.UpdateGroup;
import ${packageName}.service.${tableInfo.className}Service;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
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
@Tag(name = "${tableInfo.tableRemarks}管理")
@RequiredArgsConstructor
public class ${tableInfo.className}Controller {

    private final ${tableInfo.className}Service ${tableInfo.className?uncap_first}Service;

    @PostMapping("/page")
    @Operation(summary = "获取分页列表")
    public PageResp<${tableInfo.className}VO> page(@RequestBody PageReq<${tableInfo.className}DTO> req) {
        return ${tableInfo.className?uncap_first}Service.page(req);
    }

    @PostMapping("/{id}")
    @Operation(summary = "根据id查询")
    public Resp<${tableInfo.className}VO> findById(@PathVariable @Parameter(description = "主键id") Long id) {
        return ${tableInfo.className?uncap_first}Service.findById(id);
    }

    @PostMapping("/add")
    @Operation(summary = "新建")
    public Resp<Boolean> add(@RequestBody @Validated({InsertGroup.class, Default.class}) Req<${tableInfo.className}DTO> req) {
        return ${tableInfo.className?uncap_first}Service.add(req);
    }

    @PostMapping("/edit")
    @Operation(summary = "编辑")
    public Resp<Boolean> edit(@RequestBody @Validated({UpdateGroup.class, Default.class}) Req<${tableInfo.className}DTO> req) {
        return ${tableInfo.className?uncap_first}Service.edit(req);
    }

    @PostMapping("/enable")
    @Operation(summary = "启用")
    public Resp<Boolean> enable(@RequestBody @Parameter(description = "主键id列表") Req<List<Long>> req) {
        return ${tableInfo.className?uncap_first}Service.updateStateByIds(req.getData(), Constants.ENABLE);
    }

    @PostMapping("/disable")
    @Operation(summary = "禁用")
    public Resp<Boolean> disable(@RequestBody @Parameter(description = "主键id列表") Req<List<Long>> req) {
        return ${tableInfo.className?uncap_first}Service.updateStateByIds(req.getData(), Constants.DISABLE);
    }

    @PostMapping("/delete")
    @Operation(summary = "删除")
    public Resp<Boolean> delete(@RequestBody @Parameter(description = "主键id列表") Req<List<Long>> req) {
        return ${tableInfo.className?uncap_first}Service.delete(req.getData());
    }

}