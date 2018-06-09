bin/portland.img: bin/boot.bin bin/fs/PORTLAND
	dd if=/dev/zero of=bin/portland.img count=1440 bs=1024
	dd if=bin/boot.bin of=bin/portland.img seek=0 count=1 conv=notrunc
	mcopy -i portland.img -s fs/* ::

bin/boot.bin:
	mkdir bin
	nasm -f elf32 -o bin/boot.bin src/boot.asm

bin/fs/PORTLAND:
	mkdir -p bin/fs
	i386-elf-gcc -c src/kernel/main.c -o bin/fs/PORTLAND -ffreestanding

clean:
	rm bin -r
