#!/bin/bash

echo "Cleaning up previous output..."
hdfs dfs -rm -r /term-count-doc-and-term-output

echo "Running term-count-doc-and-term MapReduce job..."
hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.4.1.jar \
    -D stream.num.map.output.key.fields=2 \
    -input /textcorpora \
    -output /term-count-doc-and-term-output \
    -mapper term-count-doc-and-term_mapper.py \
    -reducer term-count-doc-and-term_reducer.py \
    -file term-count-doc-and-term/term-count-doc-and-term_mapper.py \
    -file term-count-doc-and-term/term-count-doc-and-term_reducer.py

if [ $? -ne 0 ]; then
    echo "Error: MapReduce job failed."
    exit 1
fi

echo "Job completed successfully."