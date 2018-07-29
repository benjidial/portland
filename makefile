out/portland.img: part/boot.bin portland shell textedit
	./utils/makepfs.py out/portland.img bin/boot.bin fs/*

part/boot.bin:
	mkdir part
	nasm -o part/boot.bin boot.asm

portland:
	make -C kernel
	mkdir fs
	mv kernel/out/* fs

shell:
	make -C shell
	mkdir fs
	mv shell/out/* fs/

clean:
	rm -r bin fs out
	make clean -C kernel
	make clean -C shell
