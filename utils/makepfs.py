#!/usr/bin/env python
#Make Portland File System
#Written by Benji Dial

from sys import argv
from datetime import datetime
from os import path
from math import ceil

image = open(argv[1], 'wb')
boot = open(argv[2], 'rb')

print('Writing bootsector ...')
image.write(boot.read(504))
image.write(bytes([ord('P'), ord('F'), ord('S'), 32, 0, 0]))
boot.seek(510)
image.write(boot.read(2))
boot.close()

time = int((datetime.now() - datetime(1970, 1, 1)).total_seconds()).to_bytes(8, 'little', signed=False)
sector = len(argv) - 2

for each in argv[3:]:
    print('Writing header for', each, '...')
    image.write(time)
    image.write(time)
    image.write(time)
    image.write(sector.to_bytes(8, 'little'))
    size = path.getsize(each)
    sector += ceil(size / 512.0)
    image.write(size.to_bytes(2, 'little'))
    image.write(bytes(each, 'ascii'))
    image.write(bytes([0] * (478 - len(each))))

print('Headers complete!')
image.write(bytes([0] * 512))

for each in argv[3:]:
    print('Writing', each, '...')
    f = open(each, 'rb')
    image.write(f.read())
    f.close()
    image.write(bytes([0] * (511 - (path.getsize(each) - 1) % 512)))

print('Image complete!')
image.close()
