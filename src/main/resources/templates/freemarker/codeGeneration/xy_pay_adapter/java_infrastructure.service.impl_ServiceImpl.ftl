package ${packageName}.infrastructure.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${packageName}.client.dto.req.${tableInfo.className}ReqDTO;
import com.smarter.common.dto.request.PageReq;
import com.smarter.common.dto.request.Req;
import ${packageName}.client.dto.resp.${tableInfo.className}RespDTO;
import com.smarter.common.dto.response.PageResp;
import com.smarter.common.dto.response.Resp;
import com.smarter.common.dto.response.RespCode;
import ${packageName}.infrastructure.converter.${tableInfo.className}Convertor;
import ${packageName}.infrastructure.dao.entity.${tableInfo.className}Entity;
import ${packageName}.infrastructure.dao.mapper.${tableInfo.className}Mapper;
import ${packageName}.infrastructure.service.${tableInfo.className}Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Objects;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}业务逻辑层实现类</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Service
public class ${tableInfo.className}ServiceImpl extends ServiceImpl<${tableInfo.className}Mapper, ${tableInfo.className}Entity> implements ${tableInfo.className}Service {

    @Override
    public PageResp<${tableInfo.className}RespDTO> page(PageReq<${tableInfo.className}ReqDTO> req) {
        if (Objects.isNull(req) || Objects.isNull(req.getData())) {
            return RespCode.BAD_REQUEST.pageResp();
        }
        ${tableInfo.className}Entity entity = ${tableInfo.className}Convertor.INSTANCE.dto2entity(req.getData());
        IPage<${tableInfo.className}Entity> page = new Page<>(req.getPageIndex(), req.getPageSize());
        if (req.isFetchAll()) {
            page.setSize(-1);
        }
        page = this.lambdaQuery()
                .eq(Objects.nonNull(entity.getId()), ${tableInfo.className}Entity::getId, entity.getId())
                .page(page);
        return RespCode.SUCCESS.pageResp(${tableInfo.className}Convertor.INSTANCE.entity2vo(page.getRecords()),
                page.getCurrent() < page.getPages() , page.getPages() , page.getTotal());
    }

    @Override
    public Resp<${tableInfo.className}RespDTO> findById(Long id) {
        if (Objects.isNull(id)) {
            return RespCode.BAD_PARAMETER.resp(null, "id");
        }
        return RespCode.SUCCESS.resp(${tableInfo.className}Convertor.INSTANCE.entity2vo(baseMapper.selectById(id)));
    }

    @Override
    public Resp<Boolean> add(Req<${tableInfo.className}ReqDTO> req) {
        if (Objects.isNull(req) || Objects.isNull(req.getData())) {
            return RespCode.BAD_REQUEST.resp();
        }
        ${tableInfo.className}ReqDTO reqData = req.getData();
        ${tableInfo.className}Entity ${tableInfo.className?uncap_first}Entity = new ${tableInfo.className}Entity();
        return RespCode.SUCCESS.resp(baseMapper.insert(${tableInfo.className?uncap_first}Entity) > 0);
    }

    @Override
    public Resp<Boolean> edit(Req<${tableInfo.className}ReqDTO> req) {
        if (Objects.isNull(req) || Objects.isNull(req.getData()) || Objects.isNull(req.getData().getId())) {
            return RespCode.BAD_REQUEST.resp();
        }
        ${tableInfo.className}ReqDTO reqData = req.getData();
        Boolean result = this.lambdaUpdate()
                .eq(${tableInfo.className}Entity::getId, reqData.getId())
                .update();
        return RespCode.SUCCESS.resp(result);
    }

    @Override
    public Resp<Boolean> updateStateByIds(List<Long> ids, byte state) {
        if (CollectionUtils.isEmpty(ids)) {
            return RespCode.BAD_PARAMETER.resp(false, "ids");
        }
        Boolean result = this.lambdaUpdate()
                .in(${tableInfo.className}Entity::getId, ids)
                .set(${tableInfo.className}Entity::getEnabled, state)
                .update();
        return RespCode.SUCCESS.resp(result);
    }

}