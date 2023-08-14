package com.h2o.h2oServer.global.typeHandler;

import com.h2o.h2oServer.domain.option.entity.enums.HashTag;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@MappedTypes(HashTag.class)
public class HashTagTypeHandler implements TypeHandler<HashTag> {

    @Override
    public void setParameter(PreparedStatement ps, int i, HashTag parameter, JdbcType jdbcType) throws SQLException {
        ps.setString(i, parameter.getLabel());
    }

    @Override
    public HashTag getResult(ResultSet rs, String columnName) throws SQLException {
        String label = rs.getString(columnName);
        return HashTag.fromLabel(label);
    }

    @Override
    public HashTag getResult(ResultSet rs, int columnIndex) throws SQLException {
        String label = rs.getString(columnIndex);
        return HashTag.fromLabel(label);
    }

    @Override
    public HashTag getResult(CallableStatement cs, int columnIndex) throws SQLException {
        String label = cs.getString(columnIndex);
        return HashTag.fromLabel(label);
    }
}
