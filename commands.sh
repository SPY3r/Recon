#!/bin/sh


echo "Enter file name containing domain names for recon"
read domain_file
echo "Enter name of the file for the subdomain list"
read subdomain_file
while IPFS= read -r domain; do
	echo $domain
	registrantemail=$(whois $domain | grep 'Registrant Email' | cut -d ':' -f 2 | cut -d ' ' -f 2 | tr [:upper:] [:lower:] )
	echo $registrantemail
	string_curl="https://www.reversewhois.io/?searchterm="
	string_curl1=$string_curl$registrantemail
	curl $string_curl1 > curl.html
	./filter.py 1
	rm curl.html
	sort domains.txt | uniq > domains.txt
	echo $domain >> $subdomain_file
	subfinder -d $domain >> $subdomain_file
	while IFS= read -r line; do
		echo $line
		subfinder -d $line >> $subdomain_file
	done < domains.txt
done < $domain_file
~/go/bin/naabu -list $subdomain_file >> naabu_output.txt
~/go/bin/httpx -status-code -title -tech-detect -list $subdomain_file
