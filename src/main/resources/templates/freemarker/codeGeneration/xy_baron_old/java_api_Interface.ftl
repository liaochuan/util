package ${packageName}.api;

import io.swagger.annotations.Api;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}对外接口</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Api(tags = "${tableInfo.tableRemarks}管理")
public interface ${tableInfo.className}Interface {

}