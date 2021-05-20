package ${packageName}.service;

import com.sunwayworld.lims.framework.service.GenericDaoService;
import com.sunwayworld.iframework.bean.ExtendBean;
import com.sunwayworld.iframework.bean.SplitPage;
import com.sunwayworld.iframework.bean.VCommList;
import ${packageName}.valueobject.${tableInfo.className};

import java.util.Map;

/**
 *
 * <p>Title: ${tableInfo.tableRemarks}service层</p>
 *
 * <p>Description: ${tableInfo.tableRemarks}service层</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * <p>Company: www.sunwayworld.com</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
public interface ${tableInfo.className}Service extends GenericDaoService<${tableInfo.className}> {

    VCommList<ExtendBean> select${tableInfo.className}ByCond(Map<String, String> cond, SplitPage page);

}