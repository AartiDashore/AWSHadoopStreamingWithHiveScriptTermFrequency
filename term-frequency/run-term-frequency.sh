#!/bin/bash

echo "Starting full term frequency pipeline..."

# Clean up
echo "Cleaning up previous Hive output..."
hdfs dfs -rm -r /tf-output

# Run both MapReduce jobs
./run-term-count-doc-and-term.sh
if [ $? -ne 0 ]; then
    echo "Error: First MapReduce job failed."
    exit 1
fi

./run-term-count-doc.sh
if [ $? -ne 0 ]; then
    echo "Error: Second MapReduce job failed."
    exit 1
fi

# Run Hive script
echo "Running Hive script..."
hive -f tf.hql
if [ $? -ne 0 ]; then
    echo "Error: Hive job failed."
    exit 1
fi

# Fetch final output
echo "Fetching Hive output to tf.txt..."
rm -f tf.txt
hdfs dfs -getmerge /tf-output tf.txt

# Example: generate abhor.txt as per PDF requirement
echo "Generating abhor.txt using grep..."
grep ',abhor,' tf.txt > abhor.txt

# Show a preview
echo "Preview of abhor.txt:"
cat abhor.txt

# Final cleanup message
echo "Pipeline completed. Output files: tf.txt and abhor.txt"
