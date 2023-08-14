package com.h2o.h2oServer.global.typeHandler;

import com.h2o.h2oServer.domain.option.entity.enums.OptionCategory;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(OptionCategory.class)
public class OptionCategoryTypeHandler implements TypeHandler<OptionCategory> {

    @Override
    public void setParameter(PreparedStatement ps, int i, OptionCategory parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, parameter.getLabel());
    }

    @Override
    public OptionCategory getResult(ResultSet rs, String columnName) throws SQLException {
        String label = rs.getString(columnName);
        return OptionCategory.fromLabel(label);
    }

    @Override
    public OptionCategory getResult(ResultSet rs, int columnIndex) throws SQLException {
        String label = rs.getString(columnIndex);
        return OptionCategory.fromLabel(label);
    }

    @Override
    public OptionCategory getResult(CallableStatement cs, int columnIndex) throws SQLException {
        String label = cs.getString(columnIndex);
        return OptionCategory.fromLabel(label);
    }
}
