bin/portland.img: bin/boot.bin bin/fs/PORTLAND
	umount fs
	dd if=bin/boot.bin of=bin/portland.img seek=0 count=1 conv=notrunc

bin/boot.bin:
	mkdir bin
	nasm -f elf32 -o bin/boot.bin src/boot.asm

bin/fs/PORTLAND: fs
	i386-elf-gcc -c src/kernel/main.c -o bin/fs/PORTLAND -ffreestanding

fs:
	dd if=/dev/zero of=bin/portland.img count=1440 bs=1024
	mkfs.fat -F16 bin/portland.img
	mount -o loop portland.img fs

clean:
	rm bin -r
