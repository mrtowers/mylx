all: iso

build/os.iso: build/floppy.img

build/floppy.img: build/kernel.bin build/bootloader.bin
	dd if=/dev/zero of=build/floppy.img bs=1440K count=1
	dd if=build/bootloader.bin of=build/floppy.img conv=notrunc
	dd if=build/kernel.bin of=build/floppy.img seek=1 conv=notrunc
	
build/kernel.bin: src/kernel.asm
	nasm -o build/kernel.bin src/kernel.asm

build/bootloader.bin: src/bootloader.asm
	nasm -o build/bootloader.bin src/bootloader.asm
	
build:
	mkdir build

floppy: build/floppy.img

iso: build/os.iso

run: build/floppy.img
	qemu-system-x86_64 -m 128M -fda build/floppy.img	

clean:
	rm -rf build
