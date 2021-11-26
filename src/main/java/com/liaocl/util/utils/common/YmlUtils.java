package com.liaocl.util.utils.common;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.yaml.snakeyaml.Yaml;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.net.URL;
import java.util.Map;

@SuppressWarnings("rawtypes")
public class YmlUtils {
    protected String yml = null;
    private final Logger logger = LogManager.getLogger(YmlUtils.class);

    public YmlUtils(String yml) {
        this.yml = yml;
    }

    public Object getYml(String path) {
        Yaml yaml = new Yaml();
        URL url = YmlUtils.class.getClassLoader().getResource(yml);
        if (url != null) {
            Map map;
            try {
                map = yaml.load(new FileInputStream(url.getFile()));
                return getValue(map, path);
            } catch (FileNotFoundException e) {
                logger.info("can not find the yml file, please double check");
                return null;
            }

        } else {
            return null;
        }
    }

    public static Object getValue(Map map, String value) {
        String[] values = value.split("\\.");
        Map m = map;
        int len = values.length - 1;
        for (int i = 0; i < len; i++) {
            if (m.containsKey(values[i])) {
                m = (Map) m.get(values[i]);
            } else {
                return null;
            }
        }
        return m.get(values[len]);
    }
}
