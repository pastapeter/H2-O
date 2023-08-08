package com.h2o.h2oServer.global.config;

import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;

@Configuration
@PropertySource("classpath:/application.yml")
@MapperScan(basePackages="com.h2o.h2oServer.**", sqlSessionFactoryRef="sqlSessionFactory")
public class DataSourceConfiguration {

    @Bean(name = "dataSource")
    @ConfigurationProperties(prefix = "spring.datasource.hikari")  // application.properties 중 prefix 가 들어간 key들을 찾는다.
    public DataSource DataSource() {
        return new HikariDataSource();
    }

    @Bean(name = "sqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(
            @Qualifier("dataSource") DataSource dataSource) throws Exception {

        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource);
        sqlSessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:/static/mapper/**/*.xml"));

        return sqlSessionFactory.getObject();
    }

    @Bean(name="sqlSession")
    public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(sqlSessionFactory);
    }
}
