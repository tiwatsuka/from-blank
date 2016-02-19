# add bean definitions
46i\
\
	<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">\
		<property name="host" value="${mail.host}" />\
		<property name="port" value="${mail.port}" />\
	</bean>\
\
	<bean id="passwordReissueMessage" class="org.springframework.mail.SimpleMailMessage">\
		<property name="from" value="${mail.from}" />\
		<property name="subject" value="${mail.subject}" />\
	</bean>\
\
	<cache:annotation-driven />\
\
	<bean id="cacheManager" class="org.springframework.cache.support.SimpleCacheManager">\
		<property name="caches">\
			<set>\
				<bean\
					class="org.springframework.cache.concurrent.ConcurrentMapCacheFactoryBean"\
					name="isInitialPassword" />\
				<bean\
					class="org.springframework.cache.concurrent.ConcurrentMapCacheFactoryBean"\
					name="isCurrentPasswordExpired" />\
			</set>\
		</property>\
	</bean>\
\
	<bean id="greenMailBean" class="com.icegreen.greenmail.spring.GreenMailBean" />

# add namespace
5i\
	xmlns:cache="http://www.springframework.org/schema/cache"\

# add schemaLocation
7i\
        http://www.springframework.org/schema/cache http://www.springframework.org/schema/cache/spring-cache.xsd


