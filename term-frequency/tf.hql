DROP TABLE IF EXISTS term_count;
DROP TABLE IF EXISTS doc_count;

CREATE EXTERNAL TABLE term_count (
    document_id STRING,
    term STRING,
    term_count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/term-count-doc-and-term-output';

CREATE EXTERNAL TABLE doc_count (
    document_id STRING,
    doc_count INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE
LOCATION '/term-count-doc-output';

INSERT OVERWRITE DIRECTORY '/tf-output'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT
    t.document_id,
    t.term,
    ROUND(t.term_count / d.doc_count, 5) AS frequency_pct
FROM term_count t
JOIN doc_count d
ON t.document_id = d.document_id;
