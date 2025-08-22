#!/usr/bin/python3
# In: (docid, term, count)
# Out: (docid, count)

import sys

try:
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        parts = line.split('\t')
        if len(parts) != 3:
            continue
        docid, term, count = parts
        print(f'{docid}\t{count}')
except Exception as e:
    sys.stderr.write(f'Error: {e}\n')