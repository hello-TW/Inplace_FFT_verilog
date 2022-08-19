from itertools import tee

import re
import os

read_file_path = './MULT.v'
write_file_path = './MULT_GEN.v'
p = re.compile( 'd\d+')
num_p = re.compile('\d+')
mo = []
i = 0

with open(read_file_path,'r') as f:
    lines = f.readlines()
    for index, item in enumerate(lines):
        mo.append("".join(p.findall(item)))

    for index, item in enumerate(mo):
        if(len(item) != 0):
            num = int(item[1:])
            lines[index] = '\t\t\t(START_CNT+'+str(num-64)+") : begin\n"

    for index, item in enumerate(lines):
        print(index, item)

with open(write_file_path,'w') as f:
    for index, item in enumerate(lines):
        f.write(item)