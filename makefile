bin/portland.img: bin/boot.bin bin/fs/PORTLAND bin/fs/SHELL
	dd if=/dev/zero of=bin/portland.img count=1440 bs=1024
	mkfs.fat -F16 portland.img
	mcopy -i portland.img -s fs/* ::
	dd if=bin/boot.bin of=bin/portland.img seek=0 count=3 bs=1 conv=notrunc
	dd if=bin/boot.bin of=bin/portland.img seek=62 skip=62 count=449 bs=1 conv=notrunc

bin/boot.bin:
	mkdir bin
	nasm -o bin/boot.bin src/boot.asm

bin/fs/PORTLAND:
	mkdir -p bin/fs
	gcc -o bin/main.o -c src/kernel/main.c -ffreestanding
	nasm -f elf -o bin/ivt.o src/kernel/ivt.asm
	ld -o bin/fs/PORTLAND bin/main.o bin/ivt.o -e _main -nostdlib --oformat=binary

bin/fs/SHELL:
	mkdir -p bin/fs
	nasm -o bin/fs/SHELL src/shell/shell.asm

clean:
	rm bin -r
