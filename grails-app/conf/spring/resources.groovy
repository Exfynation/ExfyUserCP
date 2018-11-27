// Place your Spring DSL code here
beans = {
	deltaSql(groovy.sql.Sql, ref('dataSource'))
	forumSql(groovy.sql.Sql, ref('dataSource_forum'))
}
