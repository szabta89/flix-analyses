#!/bin/sh

echo ""
for i in {0..1000}; do 
	start_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	java -jar flix.jar A_*.flix input/I_$i.flix --timeout 5min --threads 8
	end_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	duration=$((end_time - start_time))
	echo "$duration"
done
echo ""