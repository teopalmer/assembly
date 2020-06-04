app.exe:
	nasm -f elf64 strcopy.asm
	gcc -c main.c
	gcc -o $@ main.o strcopy.o
	./app.exe

clean:
	rm -f *.o *.exe
