TRUNCATE TABLE TestSet;
TRUNCATE TABLE TrainingSet;

WITH cte AS (
	select 1 as number
	union all 
	select number + 1 from cte
where number < 10000)
INSERT INTO TrainingSet(Id, Data1, Data2, Result) 
	select 
		number, 
		ABS(CHECKSUM(NewId())) % 99, 
		ABS(CHECKSUM(NewId())) % 99, 
		0
	from cte
OPTION (MAXRECURSION 10000);

WITH cte AS (
	select 1 as number
	union all 
	select number + 1 from cte
where number < 200)
INSERT INTO TestSet(Id, Data1, Data2, Result) 
	select 
		number, 
		ABS(CHECKSUM(NewId())) % 99, 
		ABS(CHECKSUM(NewId())) % 99, 
		0
	from cte
OPTION (MAXRECURSION 200);

UPDATE TestSet SET Result = Data1 + Data2
UPDATE TrainingSet SET Result = Data1 + Data2