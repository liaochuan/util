package ${packageName}.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 * <p>Description: ${tableInfo.tableRemarks}领域查询对象</p>
 *
 * <p>Copyright: Copyright (c) ${.now?string["yyyy"]}</p>
 *
 * @author ${author}
 * @since  ${.now?string["yyyy-MM-dd hh:mm:ss"]}
 * @version 1.0
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${tableInfo.className}QueryEntity {

    /**
     * 创建时间
     */
    private Long createTime;

}