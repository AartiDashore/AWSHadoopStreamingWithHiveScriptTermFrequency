#!/usr/bin/python3
# In: (docid, term, 1)
# Out: (docid, term, count)

import sys

current_key = None
current_count = 0

try:
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        parts = line.split('\t')
        if len(parts) != 3:
            continue
        docid, term, count = parts
        count = int(count)
        key = (docid, term)

        if current_key == key:
            current_count += count
        else:
            if current_key:
                print(f'{current_key[0]}\t{current_key[1]}\t{current_count}')
            current_key = key
            current_count = count

    if current_key:
        print(f'{current_key[0]}\t{current_key[1]}\t{current_count}')
except Exception as e:
    sys.stderr.write(f'Error: {e}\n')
