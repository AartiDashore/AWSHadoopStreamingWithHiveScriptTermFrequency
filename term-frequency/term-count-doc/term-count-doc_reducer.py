#!/usr/bin/python3
# In: (docid, count)
# Out: (docid, total_count)

import sys

current_docid = None
total_count = 0

try:
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        parts = line.split('\t')
        if len(parts) != 2:
            continue
        docid, count = parts
        count = int(count)

        if current_docid == docid:
            total_count += count
        else:
            if current_docid:
                print(f'{current_docid}\t{total_count}')
            current_docid = docid
            total_count = count

    if current_docid:
        print(f'{current_docid}\t{total_count}')
except Exception as e:
    sys.stderr.write(f'Error: {e}\n')
