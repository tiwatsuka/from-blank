# add bean definitions
__END_BEAN_DEFINITION_LINE__i\
\
	<bean id="realDataSource" class="org.apache.commons.dbcp2.BasicDataSource"\
		destroy-method="close">\
		<property name="driverClassName" value="${database.driverClassName}" />\
		<property name="url" value="${database.url}" />\
		<property name="username" value="${database.username}" />\
		<property name="password" value="${database.password}" />\
		<property name="defaultAutoCommit" value="false" />\
		<property name="maxTotal" value="${cp.maxActive}" />\
		<property name="maxIdle" value="${cp.maxIdle}" />\
		<property name="minIdle" value="${cp.minIdle}" />\
		<property name="maxWaitMillis" value="${cp.maxWait}" />\
	</bean>\
\
	<bean id="dataSource" class="net.sf.log4jdbc.Log4jdbcProxyDataSource">\
		<constructor-arg index="0" ref="realDataSource" />\
	</bean>\
\
    <bean id="realDataSourceForLogging" class="org.apache.commons.dbcp2.BasicDataSource"\
        destroy-method="close">\
        <property name="driverClassName" value="org.h2.Driver" />\
        <property name="url" value="jdbc:h2:tcp://${selenium.logDbHost}:${selenium.logDbPort}/mem:secure-login-test" />\
        <property name="username" value="sa" />\
        <property name="password" value="" />\
        <property name="defaultAutoCommit" value="false" />\
    </bean>\
\
    <bean id="dataSourceForLogging" class="net.sf.log4jdbc.Log4jdbcProxyDataSource">\
        <constructor-arg index="0" ref="realDataSourceForLogging" />\
    </bean>\
\
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">\
        <property name="dataSource" ref="dataSourceForLogging" />\
    </bean>\
\
    <tx:annotation-driven/>\
\
	<bean id="dbResetScript" class="org.springframework.core.io.ClassPathResource">\
		<constructor-arg index="0" value="${selenium.dbResetScript}" />\
	</bean>\
\
	<bean id="resourceDatabasePopulator" class="org.springframework.jdbc.datasource.init.ResourceDatabasePopulator">\
		<constructor-arg index="0" ref="dbResetScript" />\
	</bean>\
\
    <bean id="restOperations" class="org.springframework.web.client.RestTemplate">\
        <property name="requestFactory">\
            <bean class="org.springframework.http.client.SimpleClientHttpRequestFactory">\
                <property name="connectTimeout" value="${selenium.restOperations.connectTimeout:-1}" />\
                <property name="readTimeout" value="${selenium.restOperations.readTimeout:-1}" />\
            </bean>\
        </property>\
    </bean>\
\
    <bean id="dbLogAssertOperations" class="org.terasoluna.securelogin.selenium.DBLogAssertOperations">\
        <constructor-arg index="0">\
            <bean id="jdbcTemplate" class="org.springframework.jdbc.core.JdbcTemplate">\
                <property name="dataSource" ref="dataSourceForLogging" />\
                <property name="fetchSize" value="100" />\
            </bean>\
        </constructor-arg>\
    </bean>\
\
    <bean id="screenCapture"\
        class="org.terasoluna.securelogin.selenium.ScreenCapture" />\
\
    <bean id="dbLog" class="org.terasoluna.securelogin.selenium.DBLog">\
        <property name="dataSource" ref="dataSourceForLogging" />\
    </bean>\
\
    <bean id="pageSource"\
        class="org.terasoluna.securelogin.selenium.PageSource" />\
\
    <bean id="dbLogCleaner" class="org.terasoluna.securelogin.selenium.DBLogCleaner">\
        <property name="dataSource" ref="dataSourceForLogging" />\
    </bean>\
\
    <bean class="org.terasoluna.securelogin.selenium.WebDriverCreator" />\

# add namespace
__END_NAMESPACE_LINE__i\
    xmlns:tx="http://www.springframework.org/schema/tx"\

# add schemaLocation
__SCHEMALOCATION_LINE__i\
                        http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd
