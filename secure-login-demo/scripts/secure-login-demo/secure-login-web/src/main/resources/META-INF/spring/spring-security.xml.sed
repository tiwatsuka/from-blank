# add bean definitions
57i\
\
	<bean id="logoutSuccessHandler"\
		class="org.terasoluna.securelogin.app.common.security.CacheClearLogoutSuccessHandler">\
		<constructor-arg value="/" />\
	</bean>

# add intercept url
17i\
\
		<sec:intercept-url pattern="/login" access="permitAll" />\
		<sec:intercept-url pattern="/reissue/**" access="permitAll" />\
		<sec:intercept-url pattern="/api/receivedmail" access="permitAll" />\
		<sec:intercept-url pattern="/unlock/**" access="hasRole('ADMIN')" />\
		<sec:intercept-url pattern="/**" access="isAuthenticated()" />

# replace form-login
12i\
		<sec:form-login login-page="/login"\
			authentication-failure-url="/login?error=true"\
			login-processing-url="/login" username-parameter="username"\
			password-parameter="password" />
12d

# replace logout
13i\
		<sec:logout logout-url="/logout" success-handler-ref="logoutSuccessHandler"\
			delete-cookies="JSESSIONID" />
13d

# replace authentication-manager
19i\
	<sec:authentication-manager>\
		<sec:authentication-provider\
			user-service-ref="loggedInUserDetailsService">\
			<sec:password-encoder ref="passwordEncoder" />\
		</sec:authentication-provider>\
	</sec:authentication-manager>
19d
