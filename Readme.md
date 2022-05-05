PART I

Step 1: Clone the repo 
Command: git clone https://github.com/infracloudio/csvserver.git

Step 2: Pull the image "infracloudio/csvserver:latest"
Command:docker pull infracloudio/csvserver:latest

Step 3: Run the container, you'll be greeted with an error
Command: docker run infracloudio/csvserver:latest
Error: 2022/05/05 16:30:02 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory

Step 4: Write a bash script "genscv.sh" to generate a file named InputFile whose contents would look like
0,234
1,98
2,34

Script:

#!/bin/bash
file=./InputFile
if test -f "$file"; then
	rm $file
fi
if [ -z "$1" ]
then 
	range=9	
else
	range=$(expr $1 - 1)
fi
for (( i=0; i<=$range; i++ ))
do
	rand_num=$(shuf -i 1-100 -n 1)
	echo "$i, $rand_num" >> InputFile
done
echo $1


Step 5: Now re run the container by mounting the input file path
Command:  docker run -d -i -v 'pwd'\InputFile:/csvserver/inputdata infracloudio/csvserver:latest

Now the conatiner is seen running.

Step 6: Check the running conatiner
Command: docker ps

Output:

CONTAINER ID   IMAGE                           COMMAND                  CREATED              STATUS              PORTS      NAMES
9d3052051e20   infracloudio/csvserver:latest   "/csvserver/csvserver"   About a minute ago   Up About a minute   9300/tcp   boring_banzai

Step 7: Run the command docker exec to get the shell excess
Syntax: docker exec -it <Container ID> bash
Command: docker exec -it 9d3052051e20 bash

Now the shell is accessible for our container

Step 8: Check the active listening port
Command: netstat -tulnp

Output:

Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp6       0      0 :::9300                 :::*                    LISTEN      1/csvserver

We can see the container EXPOSES to port 9300

Step 9: Stop the container
Syntax: docker stop <Container ID>
Command: docker stop 9d3052051e20


Step 10: Run the container again such that it is accessible on port 9393 on host & also declare the environment variables CSVSERVER_BORDER with value as Orange
Command: docker run -d -i -v 'pwd'\InputFile:/csvserver/inputdata -p 9393:9300 -e CSVSERVER_BORDER='Orange' infracloudio/csvserver:latest


Step 11: Access the application at http://localhost:9393/
Application is now accessible on web.




