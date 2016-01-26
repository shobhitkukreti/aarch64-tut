ENTRY(RESET);

SECTIONS
     {
       . = 0x0;
       . = ALIGN(8);
       .text : { 
			*(.text) 
			*(.vectors)
	}
     }
