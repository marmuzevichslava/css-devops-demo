PID=`ps -ef | grep nixs | grep vi | grep cs662dip | cut -c 10-15`
kill $PID
