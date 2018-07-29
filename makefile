floppy: boot portland shell
	./utils/makepfs.py out/portland.img part/boot.bin part/fs/*

boot:
	mkdir part
	nasm -f bin -o part/boot.bin boot.asm

portland:
	make -C kernel
	mkdir -p part/fs
	mv kernel/out/* part/fs/

shell:
	make -C shell
	mkdir -p part/fs
	mv shell/out/* part/fs/

clean:
	rm -r bin fs out
	make clean -C kernel
	make clean -C shell
