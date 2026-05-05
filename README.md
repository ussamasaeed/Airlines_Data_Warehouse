# Airlines\_Data\_Warehouse

We create project a data warehouse using ETL tools "pentaho" and database postgressql.



In this project  we try to build small project of airline Co.



in which we create first database whose connect different system  like booking application employes portal etc.



to get data and store multiple schema multiple table.



we extract data and load main database named warehouse now,



We create pipeline first extract and load main database and second ETL pipeline,



to get data needs multiple dept place folder and apply some basic transformation



to provide data multiple deprtmants.



and last we create job to run next time pipeline.



in which we set direct restart whole data copy and get.


First we create ELT pipeline data_lake(raw_data) to warehouse and Second create ETL pipeline warehouse to different departments like Data_Science, Mangment and HR.
depts data store in execl files not in db.



you apply in real life only new data to get last update create from variable store last update.



when job start only insert new data but out project not set it, its full insert every time.  

