package com.java.web_ecommerce_spring.configs;


import com.java.web_ecommerce_spring.domain.AuthenticationProvider;
import com.java.web_ecommerce_spring.domain.User;
import com.java.web_ecommerce_spring.oauth2.CustomOAuth2;
import com.java.web_ecommerce_spring.oauth2.CustomOAuth2Service;
import com.java.web_ecommerce_spring.serviceImpls.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.InMemoryTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.Optional;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {


    @Autowired
    private DataSource dataSource;

    @Autowired
    private CustomOAuth2Service oAuth2Service;

    @Autowired
    private UserServiceImpl userService;


    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        return bCryptPasswordEncoder;
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/resources/static/admin/**");
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.jdbcAuthentication().dataSource(dataSource)
                .usersByUsernameQuery("select user_name, password,enable from user where user_name=?")
                .authoritiesByUsernameQuery("select u.user_name as username, r.name as role from user u inner join role r on r.id = u.role_id where user_name =?")
                .passwordEncoder(passwordEncoder());
    }
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();

        // C??c trang kh??ng y??u c???u login
        http.authorizeRequests().antMatchers("/", "/logout").permitAll();

        // Trang /userInfo y??u c???u ph???i login v???i vai tr?? ROLE_USER ho???c ROLE_ADMIN.
        // N???u ch??a login, n?? s??? redirect t???i trang /login.
//        http.authorizeRequests().antMatchers("/user/**").access("hasRole('ROLE_USER')");

        // Trang ch??? d??nh cho ADMIN
        http.authorizeRequests().antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')");
        http.authorizeRequests().antMatchers("/employee/**").access("hasRole('ROLE_EMPLOYEE')");
        // Khi ng?????i d??ng ???? login, v???i vai tr?? XX.
        // Nh??ng truy c???p v??o trang y??u c???u vai tr?? YY,
        // Ngo???i l??? AccessDeniedException s??? n??m ra.
        http.authorizeRequests().and().exceptionHandling().accessDeniedPage("/403");

        // C???u h??nh cho Login Form.
        http.authorizeRequests().and().formLogin()//
                // Submit URL c???a trang login
                .loginProcessingUrl("/auth/login") // Submit URL
                .loginPage("/auth/login")//
                .failureUrl("/auth/login?error=error")
                .usernameParameter("username")//
                .passwordParameter("password")
                .defaultSuccessUrl("/admin/home")//

                .and()
                .oauth2Login()
                .loginPage("/login")
                .userInfoEndpoint().userService(oAuth2Service)
                .and()
                .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                        CustomOAuth2 oauth2User = (CustomOAuth2) authentication.getPrincipal();
                        String email = oauth2User.getEmail();
                        String name = oauth2User.getName();

                        HttpSession session = request.getSession();
                        userService.processOAuthPostLogin(email, name, AuthenticationProvider.GOOGLE);
                        Optional<User> user = Optional.ofNullable(userService.findUserByEmail(email));
                        session.setAttribute("user", user.get());
                        response.sendRedirect("/public/home");
                    }
                })



                // C???u h??nh cho Logout Page.
                .and().logout().logoutUrl("/logout").logoutSuccessUrl("/logoutSuccessful")
                .deleteCookies("JSESSIONID");
        http.authorizeRequests().and() //
                .rememberMe().tokenRepository(this.persistentTokenRepository()) //
                .tokenValiditySeconds(1 * 24 * 60 * 60); // 24h
    }
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        InMemoryTokenRepositoryImpl memory = new InMemoryTokenRepositoryImpl();
        return memory;
    }

}