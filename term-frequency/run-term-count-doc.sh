#!/bin/bash

echo "Cleaning up previous output..."
hdfs dfs -rm -r /term-count-doc-output

echo "Running term-count-doc MapReduce job..."
hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.4.1.jar \
    -input /term-count-doc-and-term-output \
    -output /term-count-doc-output \
    -mapper term-count-doc_mapper.py \
    -reducer term-count-doc_reducer.py \
    -file term-count-doc/term-count-doc_mapper.py \
    -file term-count-doc/term-count-doc_reducer.py

if [ $? -ne 0 ]; then
    echo "Error: MapReduce job failed."
    exit 1
fi

echo "Job completed successfully."