# Controlling the Processor (and Peripherals)

So we know that the program counter (which stores a memory address) always has an initial value during power-on and that's how we know where the first line of code will be run is. The first instruction always has COMPLETE ACCESS to EVERY memory address on the memory map! Full control! Full privilege! But wait...

Did you already know that the features and peripherals on the processor PRETEND to be memory? Sure, some of the memory map is things like RAM, SRAM, NAND Flash- actual memory- but some parts of the memory map are other things only pretending to be memory- like the clock controller, GPIOs, PWMs, encryption accelerators, etc. Each "peripheral" has a little block of the memory map where it pretends to be memory, but actually it's using those addresses to communicate with the programmer.

For example, the GPIOs might own addresses 0x4000000-0x40001000. Maybe the programmer writes all binary 1's to 0x40000000, and that's how the processor knows to turn the GPIOs to HIGH. The programmer then writes all 0s there, and that's how the processor knows to turn that to LOW. It's all in the technical reference manual! Maybe the processor READS memory address 0x40000004, and that stores which inputs are HIGH and and LOW at the moment it's read!

So how does a programmer access these PHYSICAL memory address? Well, A) unless you're writing OS-level code, you CAN'T. Not even root! (without our special hacks 😏 ). But, if you are writing OS-level code, it looks like this:

# Examples:

## In Assembly

("Registers" `R0-13` are super-fast pre-named variables that assembly programmers have to work with. It's not much.)

```arm
MOV R0, #0x40000000 ; store the value 0x40000000 in Register R0 (# just means number)
MOV R1, #0x40000004 ; store the value 0x40000004 in Register R1 (# just means number)
LDR R2, [R0] ; Treat R0 like an address (square brackets), and get the value there and put it in R2
STR R2, [R1] ; Now store R2 into the address at R1.
```
What we just did is copy the value at address R0 to R1. The important thing is that we're specifying the memory addresses exactly.

## In C

(the examples are a little different...)

```C
// Here we create a pointer (something that stores a memory address) and
// we tell it EXACTLY what memory address to point to (0x40000000).
uint8_t *pointerToPhysicalMemory = 0x40000000;

// Now we store a binary value directly to that memory address (0x40000000).
*pointerToPhysicalMemory = 255;

// Now we read the value from that memory address.
uint8_t myVar = *pointerToPhysicalMemory;
```
`myVar` might not be `255`!

These addresses aren't really memory, just pretending to be memory! You have to read the datasheet!

For all we know, `0x40000000` is the address of a hardware random number generator, it might change each time you read it!
