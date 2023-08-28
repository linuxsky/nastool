#!/bin/bash  
  
read -s -p "Enter your password: " password  
hash=$(echo -n "$password" | sha256sum | awk '{print $1}')  
  
echo "Your password hash is: $hash"
