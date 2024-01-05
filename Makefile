all: iso

build/os.iso: build/floppy.img

build/floppy.img: build/kernel.bin
	dd if=/dev/zero of=build/floppy.img bs=1440K count=1
	dd if=build/kernel.bin of=build/floppy.img conv=notrunc
	
build/kernel.bin: src/kernel.asm build
	nasm -o build/kernel.bin src/kernel.asm
	
build:
	mkdir build

floppy: build/floppy.img

iso: build/os.iso

run: build/floppy.img
	qemu-system-x86_64 -m 128M -fda build/floppy.img	

clean:
	rm -rf build
