CREATE TABLE "XXL_JOB_GROUP"
(
"ID" NUMERIC(11,0) NOT NULL,
"APP_NAME" VARCHAR2(64) NOT NULL,
"TITLE" VARCHAR2(64) NOT NULL,
"ORDER" NUMERIC(4,0) DEFAULT 0 NOT NULL,
"ADDRESS_TYPE" NUMERIC(4,0) DEFAULT 0 NOT NULL,
"ADDRESS_LIST" VARCHAR2(512) DEFAULT NULL,
CLUSTER PRIMARY KEY("ID")) ;
COMMENT ON TABLE "XXL_JOB_GROUP" IS '执行器定义表';
COMMENT ON COLUMN "XXL_JOB_GROUP"."ADDRESS_LIST" IS '执行器地址列表，多地址逗号分隔';
COMMENT ON COLUMN "XXL_JOB_GROUP"."ADDRESS_TYPE" IS '执行器地址类型：0=自动注册、1=手动录入';
COMMENT ON COLUMN "XXL_JOB_GROUP"."APP_NAME" IS '执行器AppName';
COMMENT ON COLUMN "XXL_JOB_GROUP"."ORDER" IS '排序';
COMMENT ON COLUMN "XXL_JOB_GROUP"."TITLE" IS '执行器名称';
;

CREATE TABLE "XXL_JOB_INFO"
(
"ID" NUMERIC(11,0) NOT NULL,
"JOB_GROUP" NUMERIC(11,0) NOT NULL,
"JOB_CRON" VARCHAR2(128) NOT NULL,
"JOB_DESC" VARCHAR2(255) NOT NULL,
"ADD_TIME" TIMESTAMP(6) DEFAULT NULL,
"UPDATE_TIME" TIMESTAMP(6) DEFAULT NULL,
"AUTHOR" VARCHAR2(64) DEFAULT NULL,
"ALARM_EMAIL" VARCHAR2(255) DEFAULT NULL,
"EXECUTOR_ROUTE_STRATEGY" VARCHAR2(50) DEFAULT NULL,
"EXECUTOR_HANDLER" VARCHAR2(255) DEFAULT NULL,
"EXECUTOR_PARAM" VARCHAR2(512) DEFAULT NULL,
"EXECUTOR_BLOCK_STRATEGY" VARCHAR2(50) DEFAULT NULL,
"EXECUTOR_TIMEOUT" NUMERIC(11,0) DEFAULT 0 NOT NULL,
"EXECUTOR_FAIL_RETRY_COUNT" NUMERIC(11,0) DEFAULT 0 NOT NULL,
"GLUE_TYPE" VARCHAR2(50) NOT NULL,
"GLUE_SOURCE" CLOB,
"GLUE_REMARK" VARCHAR2(128) DEFAULT NULL,
"GLUE_UPDATETIME" TIMESTAMP(6) DEFAULT NULL,
"CHILD_JOBID" VARCHAR2(255) DEFAULT NULL,
"TRIGGER_STATUS" NUMERIC(4,0) DEFAULT 0 NOT NULL,
"TRIGGER_LAST_TIME" NUMERIC(13,0) DEFAULT 0 NOT NULL,
"TRIGGER_NEXT_TIME" NUMERIC(13,0) DEFAULT 0 NOT NULL,
NOT CLUSTER PRIMARY KEY("ID")) ;
COMMENT ON COLUMN "XXL_JOB_INFO"."ALARM_EMAIL" IS '报警邮件';
COMMENT ON COLUMN "XXL_JOB_INFO"."AUTHOR" IS '作者';
COMMENT ON COLUMN "XXL_JOB_INFO"."CHILD_JOBID" IS '子任务ID，多个逗号分隔';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_BLOCK_STRATEGY" IS '阻塞处理策略';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_FAIL_RETRY_COUNT" IS '失败重试次数';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_HANDLER" IS '执行器任务handler';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_PARAM" IS '执行器任务参数';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_ROUTE_STRATEGY" IS '执行器路由策略';
COMMENT ON COLUMN "XXL_JOB_INFO"."EXECUTOR_TIMEOUT" IS '任务执行超时时间，单位秒';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_REMARK" IS 'GLUE备注';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_SOURCE" IS 'GLUE源代码';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_TYPE" IS 'GLUE类型';
COMMENT ON COLUMN "XXL_JOB_INFO"."GLUE_UPDATETIME" IS 'GLUE更新时间';
COMMENT ON COLUMN "XXL_JOB_INFO"."ID" IS '执行器主键ID';
COMMENT ON COLUMN "XXL_JOB_INFO"."JOB_CRON" IS '任务执行CRON';
COMMENT ON COLUMN "XXL_JOB_INFO"."TRIGGER_LAST_TIME" IS '上次调度时间';
COMMENT ON COLUMN "XXL_JOB_INFO"."TRIGGER_NEXT_TIME" IS '下次调度时间';
COMMENT ON COLUMN "XXL_JOB_INFO"."TRIGGER_STATUS" IS '调度状态：0-停止，1-运行';
;

CREATE TABLE "XXL_JOB_LOCK"
(
"LOCK_NAME" VARCHAR2(50) NOT NULL,
CLUSTER PRIMARY KEY("LOCK_NAME"));
COMMENT ON COLUMN "XXL_JOB_LOCK"."LOCK_NAME" IS '锁名称';
;

CREATE TABLE "XXL_JOB_LOG"
(
"ID" NUMERIC(20,0) NOT NULL,
"JOB_GROUP" NUMERIC(11,0) NOT NULL,
"JOB_ID" NUMERIC(11,0) NOT NULL,
"EXECUTOR_ADDRESS" VARCHAR2(255) DEFAULT NULL,
"EXECUTOR_HANDLER" VARCHAR2(255) DEFAULT NULL,
"EXECUTOR_PARAM" VARCHAR2(512) DEFAULT NULL,
"EXECUTOR_SHARDING_PARAM" VARCHAR2(20) DEFAULT NULL,
"EXECUTOR_FAIL_RETRY_COUNT" NUMERIC(11,0) DEFAULT 0 NOT NULL,
"TRIGGER_TIME" TIMESTAMP(6) DEFAULT NULL,
"TRIGGER_CODE" NUMERIC(11,0) NOT NULL,
"TRIGGER_MSG" CLOB,
"HANDLE_TIME" TIMESTAMP(6) DEFAULT NULL,
"HANDLE_CODE" NUMERIC(11,0) NOT NULL,
"HANDLE_MSG" CLOB,
"ALARM_STATUS" NUMERIC(4,0) DEFAULT 0 NOT NULL,
NOT CLUSTER PRIMARY KEY("ID"))  ;
CREATE  INDEX "JOBLOG_HANDLECODE_INDEX" ON "XXL_JOB_LOG"("HANDLE_CODE" ASC)  ;
CREATE  INDEX "JOBLOG_TRIGGERTIME_INDEX" ON "XXL_JOB_LOG"("TRIGGER_TIME" ASC)  ;
COMMENT ON COLUMN "XXL_JOB_LOG"."ALARM_STATUS" IS '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_ADDRESS" IS '执行器地址，本次执行的地址';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_FAIL_RETRY_COUNT" IS '失败重试次数';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_HANDLER" IS '执行器任务handler';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_PARAM" IS '执行器任务参数';
COMMENT ON COLUMN "XXL_JOB_LOG"."EXECUTOR_SHARDING_PARAM" IS '执行器任务分片参数，格式如 1/2';
COMMENT ON COLUMN "XXL_JOB_LOG"."HANDLE_CODE" IS '执行-状态';
COMMENT ON COLUMN "XXL_JOB_LOG"."HANDLE_MSG" IS '执行-日志';
COMMENT ON COLUMN "XXL_JOB_LOG"."ID" IS '执行器主键ID';
COMMENT ON COLUMN "XXL_JOB_LOG"."JOB_GROUP" IS '任务组';
COMMENT ON COLUMN "XXL_JOB_LOG"."JOB_ID" IS '任务，主键ID';
COMMENT ON COLUMN "XXL_JOB_LOG"."TRIGGER_CODE" IS '调度-结果';
COMMENT ON COLUMN "XXL_JOB_LOG"."TRIGGER_MSG" IS '调度-日志';
COMMENT ON COLUMN "XXL_JOB_LOG"."TRIGGER_TIME" IS '调度-时间';
;

CREATE TABLE "XXL_JOB_LOGGLUE"
(
"ID" NUMERIC(11,0) NOT NULL,
"JOB_ID" NUMERIC(11,0) NOT NULL,
"GLUE_TYPE" VARCHAR2(50) DEFAULT NULL,
"GLUE_SOURCE" CLOB,
"GLUE_REMARK" VARCHAR2(128) NOT NULL,
"ADD_TIME" TIMESTAMP(6) DEFAULT NULL,
"UPDATE_TIME" TIMESTAMP(6) DEFAULT NULL,
NOT CLUSTER PRIMARY KEY("ID")) ;
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."GLUE_REMARK" IS 'GLUE备注';
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."GLUE_SOURCE" IS 'GLUE源代码';
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."GLUE_TYPE" IS 'GLUE类型';
COMMENT ON COLUMN "XXL_JOB_LOGGLUE"."JOB_ID" IS '任务，主键ID';

CREATE TABLE "XXL_JOB_REGISTRY"
(
"ID" NUMERIC(11,0) NOT NULL,
"REGISTRY_GROUP" VARCHAR2(255) NOT NULL,
"REGISTRY_KEY" VARCHAR2(255) NOT NULL,
"REGISTRY_VALUE" VARCHAR2(255) NOT NULL,
"UPDATE_TIME" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP NOT NULL,
CLUSTER PRIMARY KEY("ID")) ;
CREATE  INDEX "JOBREGISTRY_GROUP_KEY_VALUE_INDEX" ON "XXL_JOB_REGISTRY"("REGISTRY_GROUP" ASC,"REGISTRY_KEY" ASC,"REGISTRY_VALUE" ASC)  ;
CREATE  INDEX "JOBREGISTRY_UPDATETIME_INDEX" ON "XXL_JOB_REGISTRY"("UPDATE_TIME" ASC) ;

CREATE TABLE "XXL_JOB_USER"
(
"ID" NUMERIC(11,0) NOT NULL,
"USERNAME" VARCHAR2(50) NOT NULL,
"PASSWORD" VARCHAR2(50) NOT NULL,
"ROLE" NUMERIC(4,0) NOT NULL,
"PERMISSION" VARCHAR2(255) DEFAULT NULL,
CLUSTER PRIMARY KEY("ID"))  ;
CREATE UNIQUE  INDEX "JOBUSER_USERNAME_UINDEX" ON "XXL_JOB_USER"("USERNAME" ASC) ;
COMMENT ON TABLE "XXL_JOB_USER" IS '用户定义表';
COMMENT ON COLUMN "XXL_JOB_USER"."PASSWORD" IS '密码';
COMMENT ON COLUMN "XXL_JOB_USER"."PERMISSION" IS '权限：执行器ID列表，多个逗号分割';
COMMENT ON COLUMN "XXL_JOB_USER"."ROLE" IS '角色：0-普通用户、1-管理员';
COMMENT ON COLUMN "XXL_JOB_USER"."USERNAME" IS '账号';
;

CREATE SEQUENCE "SEQ_JOBGROUP" INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1;

CREATE SEQUENCE "SEQ_JOBINFO" INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1;

CREATE SEQUENCE "SEQ_JOBLOG" INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1;

CREATE SEQUENCE "SEQ_JOBLOGGLUE" INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1;

CREATE SEQUENCE "SEQ_JOBREGISTRY" INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1;

CREATE SEQUENCE "SEQ_JOBUSER" INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1;

--初始化数据
INSERT INTO xxl_job_group(id, app_name, title, "ORDER", address_type, address_list) VALUES (SEQ_JOBGROUP.nextval, 'xxl-job-executor-sample', '示例执行器', 1, 0, NULL);
INSERT INTO xxl_job_user(id, username, password, role, permission) VALUES (SEQ_JOBUSER.nextval, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
INSERT INTO xxl_job_lock ( lock_name) VALUES ( 'schedule_lock');


--2.1.1
CREATE TABLE "XXL_JOB_LOG_REPORT"
(
"ID" INT NOT NULL,
"TRIGGER_DAY" DATETIME(6) DEFAULT NULL,
"RUNNING_COUNT" INT DEFAULT '0' NOT NULL,
"SUC_COUNT" INT DEFAULT '0' NOT NULL,
"FAIL_COUNT" INT DEFAULT '0' NOT NULL,
CLUSTER PRIMARY KEY("ID"))  ;
CREATE UNIQUE  INDEX "JOBLOGREPORT_TRIGGERDAY_UINDEX" ON  "XXL_JOB_LOG_REPORT"("TRIGGER_DAY" ASC) ;
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."FAIL_COUNT" IS '执行失败-日志数量';
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."RUNNING_COUNT" IS '运行中-日志数量';
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."SUC_COUNT" IS '执行成功-日志数量';
COMMENT ON COLUMN "XXL_JOB_LOG_REPORT"."TRIGGER_DAY" IS '调度-时间';

CREATE SEQUENCE "SEQ_JOBLOGREPORT"  INCREMENT BY 1 START WITH 1 MAXVALUE 9223372036854775807 MINVALUE 1  ;