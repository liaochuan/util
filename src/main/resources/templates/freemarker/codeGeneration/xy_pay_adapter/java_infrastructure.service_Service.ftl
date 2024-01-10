package ${packageName}.infrastructure.service;

import com.baomidou.mybatisplus.extension.service.IService;
import ${packageName}.client.dto.req.${tableInfo.className}ReqDTO;
import com.smarter.common.dto.request.PageReq;
import com.smarter.common.dto.request.Req;
import ${packageName}.client.dto.resp.${tableInfo.className}RespDTO;
import com.smarter.common.dto.response.PageResp;
import com.smarter.common.dto.response.Resp;
import ${packageName}.infrastructure.dao.entity.${tableInfo.className}Entity;

import java.util.List;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}业务逻辑层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
public interface ${tableInfo.className}Service extends IService<${tableInfo.className}Entity> {
                                                                                              
    /**
    * 分页查询列表
    * @param req 分页请求体
    * @return 分页响应体
    */
    PageResp<${tableInfo.className}RespDTO> page(PageReq<${tableInfo.className}ReqDTO> req);

    /**
    * 根据id查询信息
    * @param id 的id
    * @return 信息
    */
    Resp<${tableInfo.className}RespDTO> findById(Long id);
    
    /**
    * 创建
    * @param req 信息请求体
    * @return 创建结果状态响应体
    */
    Resp<Boolean> add(Req<${tableInfo.className}ReqDTO> req);
    
    /**
    * 修改
    * @param req 信息请求体
    * @return 修改结果状态响应体
    */
    Resp<Boolean> edit(Req<${tableInfo.className}ReqDTO> req);
    
    /**
    * 根据id更新状态
    * @param ids id列表
    * @param state 需要更新的状态
    * @return 更新结果状态响应体
    */
    Resp<Boolean> updateStateByIds(List<Long> ids, byte state);

}