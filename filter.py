#!/usr/bin/python3

import sys

data_file = open("domains.txt","a")

if(sys.argv[1] == '1'):
	file = open("curl.html","r")
	lines= file.readlines()
	for line in lines:
		if 'Reverse Whois results for' in line:
			lines = line
			break	
	line = line.split("<td>")
	break_len_length = len(line)
	counter = 0
	count = 1
	for i in line:
		i = i.replace('</td>','')
		if(counter == 1):
			data_file.write(i)
			data_file.write('\n')
			counter=0
		if(i == str(count)):
			count=count+1
			counter=1

	file.close()

data_file.close()
