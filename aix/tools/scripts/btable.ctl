load data
infile 'btable.dat'
append
into table benchmark_runs
fields terminated by " " optionally enclosed by '"'
(run_name,
run_date,
driver,
transaction,
timestamp,
response)
