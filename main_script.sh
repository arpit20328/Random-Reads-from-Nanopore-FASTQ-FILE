#!/bin/bash


echo "Welcome to Random Reads Selection Script Made by Arpit Mathur"

echo "Please enter <PATH of your FASTQ> <Random number of Reads you want> <Number of Simulations>"

echo "Your entered PATH is : $1 "

echo "Random number of Reads you want to extract from your FASTQ file provided : $2"

echo "Number of Simulations your entered: $3"


mkdir -p Random_reads

grep  "^@" $1 > Random_reads/all_reads.txt 

echo "All Reads from your ONT FASTQ file stored in file named all_reads.txt"

cd Random_reads

n=$(wc -l < all_reads.txt)

cd ..

echo "Number of lines in all_reads.txt is : $n"

s=$3
cd Random_reads 

for i in $(seq 1 $3); do
  shuf -n $2 all_reads.txt  > random_$i.txt 
done

cat *.txt  >  combined_random_reads.txt 


shuf -n $2 combined_random_reads.txt > result.txt 


echo "Results are saved in the folder named Random_reads with file named result.txt"

n=$(wc -l < result.txt)

while IFS= read -r line; do
       grep -n "$line"  $1 | cut -d: -f1 >> target_lines_of_fastq_file.txt

done < result.txt


while read -r  line; do

     target_line_start=$line
     target_line_end=$((line + 3))
    
    echo "$target_line_start"
    echo "$target_line_end"
    
    awk 'NR>=$target_line_start && NR<=$target_line_end' $1  >> final.fastq
    


done < target_lines_of_fastq_file.txt






