package com.xxl.job.admin;

import com.xxl.job.admin.core.thread.JobFailMonitorHelper;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author xuxueli 2018-10-28 00:38:13
 */
@SpringBootApplication
public class DmXxlJobAdminApplication {

	public static void main(String[] args) {
        SpringApplication.run(DmXxlJobAdminApplication.class, args);
		JobFailMonitorHelper.getInstance().toStop();
	}

}