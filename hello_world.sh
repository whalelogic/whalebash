#! /bin/bash

full_name="Keith Thomson"
user_name=$USER


echo "Hello, $USER! Welcome to the world of Bash scripting."
echo "Your full name is $full_name."
echo "Your username is $user_name."

for i in {1..5}
do
  echo "This is message number $i"
done


a=4
b=17
c=43

array=($a $b $c)

echo "The array elements are: ${array[@]}"

for i in "${array[@]}"
do
  echo "Array element: $i"
  echo square=$((i * i))
done

if [ $a -lt $b ]; 
then 
  echo "$a is less than $b"
else
  echo "$a is not less than $b"
fi
