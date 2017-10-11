#!/bin/sh

echo ""
echo "Google Truth"
for i in {1..5}; do 
	start_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	java -jar flix.jar --verifier A_*.flix I_TRUTH.flix --timeout 5min --threads 8
	end_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	duration=$((end_time - start_time))
	echo "$duration"
done

echo ""
echo "Google Gson"
for i in {1..5}; do 
	start_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	java -jar flix.jar --verifier A_*.flix I_GSON.flix
	end_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	duration=$((end_time - start_time))
	echo "$duration"
done

echo ""
echo "PostgreSQL JDBC"
for i in {1..5}; do 
	start_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	java -jar flix.jar --verifier A_*.flix I_POSTGRESQL.flix
	end_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	duration=$((end_time - start_time))
	echo "$duration"
done

echo ""
echo "BerkeleyDB"
for i in {1..5}; do 
	start_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	java -jar flix.jar --verifier A_*.flix I_BERKELEYDB.flix
	end_time=$(ruby -e 'puts (Time.now.to_f * 1000).to_i')
	duration=$((end_time - start_time))
	echo "$duration"
done