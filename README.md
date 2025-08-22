# AWS Hadoop Streaming With Hive Script Term Frequency

## Overview: Term Frequency Hadoop Project

### Project Description:
---------------------
This project runs a Hadoop Streaming pipeline that calculates term frequency statistics across a set of textcorpora. It involves two MapReduce jobs (2 Mappers and 2 Reducers python files), three shell scripts and a Hive query for further processing.

### Folder Structure:
-----------------
- term-count-doc-and-term/
    - term-count-doc-and-term_mapper.py
    - term-count-doc-and-term_reducer.py
- term-count-doc/
    - term-count-doc_mapper.py
    - term-count-doc_reducer.py
- textcorpora/
    - [Your text files go here]
- run-term-count-doc-and-term.sh
- run-term-count-doc.sh
- run-term-frequency.sh
- tf.hql

The folder structure is same in local as well as in hadoop hdfs as well.

## Setup Instructions:
-------------------

1. Upload the textcorpora folder to HDFS:
   $ hadoop fs -put textcorpora /

2. Make sure all scripts and mapper/reducer files are present locally (on your Linux machine), and not just in HDFS:
   - term-count-doc-and-term/*.py
   - term-count-doc/*.py
   - run-term-count-doc-and-term.sh
   - run-term-count-doc.sh
   - run-term-frequency.sh
   - tf.hql

3. Give executable permissions in both hdfs as well as in local files:
   $ chmod +x run-term-count-doc-and-term.sh
   $ chmod +x run-term-count-doc.sh
   $ chmod +x run-term-frequency.sh
   $ chmod +x tf.hql
   $ chmod +x term-count-doc-and-term/*.py
   $ chmod +x term-count-doc/*.py

   for Hadoop:
   $hadoop fs -chmod +x run-term-count-doc-and-term.sh run-term-count-doc.sh run-term-frequency.sh tf.hql term-count-doc-and-term/*.py term-count-doc/*.py

## How to Run:
-----------
Run the full pipeline:
$ ./run-term-frequency.sh

This will:
- Clean up previous outputs.
- Run both MapReduce jobs.
- Execute Hive query (tf.hql).

## Expected Output:
----------------
- HDFS output folders:
  - /term-count-doc-and-term-output
  - /term-count-doc-output
  - /tf-output

- Results will be printed by the scripts using `hadoop fs -cat` and `grep` to display the processed results.

## Notes:
------
- The Hadoop Streaming JAR file path could varies depending upon the system. Ensure the Hadoop Streaming JAR path is correct in your scripts. My JAR file:
  /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.4.1.jar

  To find your own JAR file path, execute:
  $find /usr/ -name "hadoop-streaming*.jar" 2>/dev/null

- The mapper scripts use environment variables like map_input_file or mapreduce_map_input_file to get document IDs. This is already handled in the code, mntioned in '#' comments.

- Do not move the mapper/reducer files only to HDFS; they MUST exist locally when submitting the job.

- Also ensure that the 2 files shakespeare-caesar.txt and chesterton-ball.txt files are deleted before using textcorpora folder as input.

# Troubleshooting:
----------------
If you see errors like:
- "No such file or directory" for mapper files,
  --> Verify the files exist locally, not just in HDFS.

- PipeMapRed.waitOutputThreads() error:
  --> This likely means your mapper script crashed. Test it locally with:
      $ echo "test line" | ./term-count-doc-and-term/term-count-doc-and-term_mapper.py
