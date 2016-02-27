ENTRY(RESET);

MEMORY
{
	flash (rx) : ORIGIN = 0x0, LENGTH = 128M
	ram (rwx) : ORIGIN = 0x80000000, LENGTH = 2048M
}


SECTIONS
{
	.text :	
	     {
		     . = ALIGN(8);
		     *(.text) 
		     *(.vectors)

	     } > flash


.data :
{
	. = ALIGN(8);
	*(.data)

} > flash AT > ram	



.bss :
{
	. = ALIGN(8);
	*(.bss)
	*(COMMON)
	
} > ram


}
