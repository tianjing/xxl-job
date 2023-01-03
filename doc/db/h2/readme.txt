1、pom 增加 h2 依赖
        <!-- 内存数据库h2-->
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>

2、数据库连接
spring.datasource.url=jdbc:h2:file:C:/tianjing/github/xxl-job/xxl-job-admin/target/xxl-jobdb
spring.datasource.driver-class-name=org.h2.Driver

3、使用数据库 任选其一
 （1）已经初始化好的 数据库 h2-xxl-jobdb.zip
 （2）使用脚本初始化数据库
