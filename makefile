bin/portland.img: boot portland shell textedit
	./utils/makepfs.py bin/portland.img bin/boot.bin bin/fs/*

bin/boot.bin:
	mkdir bin
	nasm -o bin/boot.bin src/boot.asm

portland:
	mkdir -p bin/fs/obj
	gcc -o bin/obj/main.o -c kernel/main.c -ffreestanding
	nasm -f elf -o bin/obj/ivt.o kernel/ivt.asm
	nasm -f elf -o bin/obj/kbd.o kernel/kbd.asm
	ld -o bin/fs/portland bin/obj/main.o bin/obj/ivt.o bin/obj/kbd.o -e main -nostdlib --oformat=binary

shell:
	mkdir -p bin/fs/obj
	gcc -o bin/obj/shell.o -c shell/shell.c -ffreestanding
	ld -o bin/fs/shell bin/obj/shell.o -e main -nostdlib --oformat=binary

textedit:
	mkdir -p bin/fs/obj
	nasm -f elf -o bin/obj/textedit.o textedit/textedit.asm
	ld -o bin/fs/textedit bin/obj/textedit.o -e main -nostdlib --oformat=binary

clean:
	rm bin -r
