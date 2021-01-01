# What is an Interrupt?

Okay, this one is really easy, but we need to continue background to get to the crazy hacker linux stuff.

Like I said before about the program counter- the program counter usually just increments one by one, executing each line. Sometimes it jumps if an instruction tells it to.

An interrupt is a trigger- a voltage on a pin, a hardware timer, or some event, which causes the processor to save it's current program counter and other state information, and then jump automatically to a pre-set memory address and start executing the code there. When it's done with the interrupt, it goes back to where it was and continues as normal.

On the memory map, there a section called the NVIC, each of these addresses record an address of a function, and each address is associated with one type of interrupt. When that interrupt is triggered, the program counter jumps to that function.
