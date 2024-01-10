package ${packageName}.service.impl;

import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import ${packageName}.api.dto.req.${tableInfo.className}DTO;
import com.xy.ad.common.api.dto.req.PageReq;
import com.xy.ad.common.api.dto.req.Req;
import ${packageName}.api.dto.resp.${tableInfo.className}VO;
import com.xy.ad.common.api.dto.resp.PageResp;
import com.xy.ad.common.api.dto.resp.Resp;
import com.xy.ad.common.api.dto.resp.RespCode;
import ${packageName}.converter.${tableInfo.className}Convertor;
import ${packageName}.dao.${tableInfo.className}Dao;
import ${packageName}.entity.${tableInfo.className}Entity;
import ${packageName}.service.${tableInfo.className}Service;
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
public class ${tableInfo.className}ServiceImpl extends ServiceImpl<${tableInfo.className}Dao, ${tableInfo.className}Entity> implements ${tableInfo.className}Service {

    @Override
    public PageResp<${tableInfo.className}VO> page(PageReq<${tableInfo.className}DTO> req) {
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
    public Resp<${tableInfo.className}VO> findById(Long id) {
        if (Objects.isNull(id)) {
            return RespCode.BAD_PARAMETER.resp(null, "id");
        }
        return RespCode.SUCCESS.resp(${tableInfo.className}Convertor.INSTANCE.entity2vo(baseMapper.selectById(id)));
    }

    @Override
    public Resp<Boolean> add(Req<${tableInfo.className}DTO> req) {
        if (Objects.isNull(req) || Objects.isNull(req.getData())) {
            return RespCode.BAD_REQUEST.resp();
        }
        ${tableInfo.className}Entity entity = ${tableInfo.className}Convertor.INSTANCE.dto2entity(req.getData());
        return RespCode.SUCCESS.resp(baseMapper.insert(entity) > 0);
    }

    @Override
    public Resp<Boolean> edit(Req<${tableInfo.className}DTO> req) {
        if (Objects.isNull(req) || Objects.isNull(req.getData()) || Objects.isNull(req.getData().getId())) {
            return RespCode.BAD_REQUEST.resp();
        }
        ${tableInfo.className}Entity entity = ${tableInfo.className}Convertor.INSTANCE.dto2entity(req.getData());
        Boolean result = this.lambdaUpdate()
                .eq(${tableInfo.className}Entity::getId, entity.getId())
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

    @Override
    public Resp<Boolean> delete(List<Long> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return RespCode.BAD_PARAMETER.resp(false, "ids");
        }
        return RespCode.SUCCESS.resp(this.removeBatchByIds(ids));
    }

}