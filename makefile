bin/portland.img: bin/boot.bin bin/fs/PORTLAND
	dd if=/dev/zero of=bin/portland.img count=1440 bs=1024
	mkfs.fat -F16 portland.img
	mcopy -i portland.img -s fs/* ::
	dd if=bin/boot.bin of=bin/portland.img seek=0 count=3 bs=1 conv=notrunc
	dd if=bin/boot.bin of=bin/portland.img seek=62 skip=62 count=449 bs=1 conv=notrunc

bin/boot.bin:
	mkdir bin
	nasm -f elf32 -o bin/boot.bin src/boot.asm

bin/fs/PORTLAND:
	mkdir -p bin/fs
	i386-elf-gcc -c src/kernel/main.c -o bin/fs/PORTLAND -ffreestanding

clean:
	rm bin -r
