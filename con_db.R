library(RPostgreSQL)

drv<-dbDriver("PostgreSQL")
con<-dbConnect(drv,dbname="training_data",host="localhost", port=5432,user="CASH", password="1992")
df_postgres<-dbGetQuery(con, "SELECT * FROM training_data_set")
#imports the data stored remotely in the table name on connection conn. Use the field row.names as the row.names attribute of the output data.frame. Returns a data.frame. Eg. dframe <-dbReadTable(con,"TableName").
mytable<-dbReadTable(con, "training_data_set")
#returns the list of tables available on the connection.
#dbListTables(con)
names(mytable)



# close the connection
dbDisconnect(con)
dbUnloadDriver(drv)

