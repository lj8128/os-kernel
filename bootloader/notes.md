# Notes on the Bootloader

## Scope

We will restrict our discussion below to computers with processors that
implement the x86-64 computer architecture. Further, we will only
consider bootloaders that interface with an implementation of the BIOS 
(Basic Input/Output System) firmware standard.

UEFI (Unified Extensible Firmware Interface) is a more modern firmware
standard, which removes many of the limitations the BIOS imposes on the
bootloader. For instance, the BIOS requires that the bootloader's
instructions:

1. fit into 512 bytes;
2. only use the first megabyte of the computer's memory; and
3. be compiled as binary.

By contrast, UEFI is able to understand several file systems. This 
removes the first constraint by allowing developers to write 
bootloaders whose instructions vary in their size. This size seems to 
be restricted only by the file system's limits and the computer's disk 
space. 

Further, the UEFI allows the bootloader to use the entirety of the 
computer's memory. Finally, the UEFI also understands executable 
formats, which means the bootloader's instructions no longer need to be 
compiled in raw binary machine code.

We will further discuss some of these comparative advantages of the 
UEFI below in passing. But we will completely neglect the problem of
how a bootloader might be written to interface with a UEFI firmware.

## Preliminaries: The BIOS

A BIOS implementation is a program that is stored in non-volatile
memory, i.e., storage that the CPU can access directly, and whose data
persists even after its computer shuts down. This memory medium used to
be ROM (read-only memory) whose contents were hard-wired during the
ROM's manufacture and could not be changed.

But more recently, EEPROM (Electrically Erasable Programmable Read-Only
Memory) has displaced ROM. As its name suggests, the contents of an 
EEPROM can be changed after the fact, by being erased and rewritten
electrically. Flash memory is an instance of EEPROM.

This move from ROM to EEPROM allowed the BIOS to be rewritten. Indeed,
this is even done remotely these days, as can be witnessed in the 
screenshot below, where the BIOS of a Dell computer is being updated
with BIOS Guard. 

![Dell BIOS Update](dell-firmware-update.webp "Dell BIOS update")

This image was actually taken by [a concerned owner](https://www.reddit.com/r/Dell/comments/pg8vxs/is_this_normal_for_dell_to_issue_an_over_the_air/) who thought it was 
strange to have the firmware updated remotely. Others also [shared the
concern](https://www.dell.com/community/en/conversations/windows-10/my-windows-10-laptop-updated-and-there-was-also-bios-firrmware-update/647f8794f4ccf8a8de6cfc30).

Regardless of the storage medium, when a computer is turned on, the
BIOS program stored in the medium is executed by the CPU. This program 
does several things, but most prominently, it:

1. does a Power-On Self-Test, or POST, which checks to ensure that the
core hardware of the computer (the processor, RAM, etc.) are
functioning normally; and
2. searches for a boot sector.

======= RESUME HERE =======
A boot sector is a section of memory 512 mb long...bootable
device...magic keywords (which are metadata. Also, remember to mention 
the memory origin 0x7c something something).

## The Bootloader

Describe how the bootloader written for PeachOS works. The main object
of the assembler is to assemble a 512-mb stretch of binary code that
fits into the boot sector. 
