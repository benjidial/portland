bin/portland.img: bin/boot.bin bin/kernel.bin
	TODO

bin/boot.bin:
	mkdir bin
	nasm -f elf32 -o bin/boot.bin src/boot.asm

bin/kernel.bin:
	mkdir -p bin/fs
	i386-elf-gcc -c src/kernel/main.c -o bin/fs/PORTLAND -ffreestanding

clean:
	rm bin -r
