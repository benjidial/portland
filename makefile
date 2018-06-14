bin/portland.img: bin/boot.bin bin/fs/PORTLAND bin/fs/SHELL
	tar cf bin/fs.tar bin/fs/
	cat bin/boot.bin bin/fs.tar bin/portland.img

bin/boot.bin:
	mkdir bin
	nasm -o bin/boot.bin src/boot.asm

bin/fs/PORTLAND:
	mkdir -p bin/fs/obj
	gcc -o bin/obj/main.o -c src/kernel/main.c -ffreestanding
	nasm -f elf -o bin/obj/ivt.o src/kernel/ivt.asm
	nasm -f elf -o bin/obj/kbd.o src/kernel/kbd.asm
	ld -o bin/fs/PORTLAND bin/obj/main.o bin/obj/ivt.o bin/obj/kbd.o -e main -nostdlib --oformat=binary

bin/fs/SHELL:
	mkdir -p bin/fs/obj
	gcc -o bin/obj/shell.o -c src/shell/shell.c -ffreestanding
	ld -o bin/fs/SHELL bin/obj/shell.o -e main -nostdlib --oformat=binary

clean:
	rm bin -r
