#!/bin/bash

for i in {1..100}
do
    echo "$i"
done


#!/bin/bash
# Display numbers from 1 to 100 using a while loop
i=1
while [ $i -le 100 ]
do
    echo "$i"  # Print the current number
    ((i++))    # Increment the counter
done




#!/bin/bash
# Display numbers from 1 to 100 using an until loop
i=1
until [ $i -gt 100 ]
do
    echo "$i"  # Print the current number
    ((i++))    # Increment the counter
done
