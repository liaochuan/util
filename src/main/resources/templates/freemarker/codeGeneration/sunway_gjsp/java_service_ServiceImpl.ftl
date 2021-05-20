package ${packageName}.service;

import com.sunwayworld.lims.framework.service.GenericDaoSupport;
import org.springframework.stereotype.Service;
import com.sunwayworld.iframework.bean.UserInfo;
import com.sunwayworld.iframework.bean.ExtendBean;
import com.sunwayworld.iframework.bean.SplitPage;
import com.sunwayworld.iframework.bean.VCommList;
import ${packageName}.valueobject.${tableInfo.className};

import java.util.Date;
import java.util.Map;

/**
 *
 * <p>Title: ${tableInfo.tableRemarks}service层实现</p>
 *
 * <p>Description: ${tableInfo.tableRemarks}service层实现</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * <p>Company: www.sunwayworld.com</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Service
public class ${tableInfo.className}ServiceImpl extends GenericDaoSupport<${tableInfo.className}> implements ${tableInfo.className}Service {

    @Override
    protected String getPrimaryKeyValue(${tableInfo.className} t) {
        return t.getId();
    }

    @Override
    protected void processBeforeInsert(${tableInfo.className} t, UserInfo userInfo) {
        t.setRecordtime(new Date());
        t.setRecordercode(userInfo.getUsercode());
        t.setRecorderdesc(userInfo.getUserdesc());
    }

    @Override
    public VCommList<ExtendBean> select${tableInfo.className}ByCond(Map<String, String> cond, SplitPage page) {
        return this.selectExtendBeanListByCond(
                "${packageName}.sql.select${tableInfo.className}ByCond", cond, page);
    }
}