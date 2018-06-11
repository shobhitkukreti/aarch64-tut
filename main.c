const int UART = 0x09000000;

void print(char buf[], int size){

char *tmp = (char*)UART;
int i=0;
for(i=0; i<size;i++)
	*tmp = buf[i];	

}


void c_entry() {
int variable_a = 10;
char buff[7] = "Hello\n";
print(buff, 8);
}
