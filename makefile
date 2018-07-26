out/portland.img: part/boot.bin portland shell textedit
	./utils/makepfs.py out/portland.img bin/boot.bin fs/*

part/boot.bin:
	mkdir part
	nasm -o part/boot.bin boot.asm

portland:
	mkdir fs
	#TODO

shell:
	mkdir fs
	#TODO

textedit:
	mkdir fs
	#TODO

clean:
	rm -r bin fs out
