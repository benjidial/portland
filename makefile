kernel:
	mkdir out
	nasm -f bin -o out/portland source/main.asm

clean:
	rm -r out
