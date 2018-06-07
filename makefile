bin/portland.iso: bin/iso/boot/portland.bin bin/iso/boot/grub/grub.cfg
	grub-mkrescue -o bin/portland.iso bin/iso

bin/iso/boot/portland.bin: bin/boot.o bin/kernel.o
	mkdir -p bin/iso/boot
	i386-elf-gcc -T src/link.ld -o bin/iso/boot/portland.bin -ffreestanding -nostdlib bin/boot.o bin/kernel.o -lgcc

bin/boot.o:
	mkdir bin
	nasm -f elf32 -o bin/boot.o src/boot.asm

bin/kernel.o:
	mkdir bin
	i386-elf-gcc -c src/kernel/main.c -o bin/kernel.o -ffreestanding

bin/iso/boot/grub/grub.cfg:
	mkdir -p bin/iso/boot/grub
	cp src/grub.cfg bin/iso/boot/grub/grub.cfg

clean:
	rm bin -r
