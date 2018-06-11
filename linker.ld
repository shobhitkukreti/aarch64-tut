ENTRY(RESET);

MEMORY
{
	flash (rx) : ORIGIN = 0x0, LENGTH = 128M
	/* ram (rwx) : ORIGIN = 0x80000000, LENGTH = 2048M */
	ram (rwx) : ORIGIN = 0x40000000, LENGTH = 2048M
}

	stack_size = 1024;
	heap_size = 256;

	/* define beginning and ending of stack */
	_stack_start = ORIGIN(ram)+LENGTH(ram);
	_stack_end = _stack_start - stack_size;


SECTIONS
{
	.text :	
	{
		. = ALIGN(8);
		*(.text);
		*(.vectors);

	} > flash
	

	.rodata :
      {
        *(.rodata)
        rodata_end = .;
      } > flash
	
	

	.data :
	{
		. = ALIGN(8);
		*(.data);
		*(.data*)

	} > ram AT > flash
	data_load_start = LOADADDR(.data);	



	.bss :
	{
		. = ALIGN(8);
		*(.bss);
		*(COMMON);

	} > ram


}
