#!/usr/bin/env python

from sys import argv
from datetime import datetime
from os import path

image = open(argv[0], 'w')
boot = open(argv[1], 'r')

print 'Writing bootsector...'
image.write(boot.read(504))
image.write('PFS \0\0')
boot.seek(510)
image.write(boot.read(2))
boot.close()

time = (datetime.now() - dt(1970, 1, 1)).total_seconds().to_bytes(8, 'little', signed=False)
sector = len(argv) - 1

for each in argv[2:]:
    print 'Writing header for ', each, '...'
    image.write(time)
    image.write(time)
    image.write(time)
    image.write(sector.to_bytes(8, 'little'))
    size = path.getsize(each)
    sector += math.ceil(size / 512.0)
    image.write(size.to_bytes(2, 'little'))
    image.write(each)
    image.write('\0' * (478 - len(each)))

print 'Headers complete!'
image.write('\0' * 512)

for each in argv[2:]:
    print 'Writing ', each, '...'
    f = open(each, 'r')
    image.write(f.read())
    f.close()
    image.write('\0' * (511 - (path.getsize(each) - 1) % 512))

print 'Image complete!'
image.close()
