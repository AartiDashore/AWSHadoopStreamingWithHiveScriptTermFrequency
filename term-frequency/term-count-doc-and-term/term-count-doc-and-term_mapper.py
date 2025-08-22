#!/usr/bin/python3
# In: string w/ document or line from document
# Out: (docid, term, 1)
import sys
import re
import os

def termify(word):
    regex = re.compile('[^a-z]')
    return regex.sub('', word.lower())

for line in sys.stdin:
    docid = os.path.splitext( \
    os.path.basename(os.getenv('map_input_file')))[0]
    #map_input_file = os.getenv('map_input_file') or os.getenv('mapreduce_map_input_file')
    #if map_input_file:
        #docid = os.path.splitext(os.path.basename(map_input_file))[0]
    #else:
        #docid = 'unknown_doc'


    for term in map(termify, line.strip().split()):
        if term:
            print('%s\t%s\t%s' % (docid, term, 1))