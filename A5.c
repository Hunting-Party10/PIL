#include<stdio.h>
#include<dos.h>


const int deletefile(const char *filename)
{
	FILE fp = fopen(filename,"w");
	reg1.h.ah =0x41;
	reg1.x.dx = FP_OFF(fp);
	intdos(&reg1,&reg2);
	fclose(fp);
	return reg2.x.cflag;
}

void createdir()
{

}

void copyfile()
{

}


int main()
{
	int choice;
	char name[25];
	do
	{
		printf("Press 1 to Delete File\n");
		printf("Press 2 to Create Directory\n");
		printf("Press 3 to Copy File\n");
		printf("Press 4 to Exit\n");
		printf("Enter Choice:");
		scanf("%d",&choice);
		switch(choice)
		{
			case 1:
				printf("Enter File Name:");
				scanf("%[^/n]s",name);
				deletefile(name);
				break;
			case 2:
				printf("Enter File Name:");
				scanf("%[^/n]s",name);
				
				break;
			case 3:
				printf("Enter File Name:");
				scanf("%[^/n]s",name);
				
				break;
			case 4:
				break;
			default:
				printf("Enter Valid option\n");
				
		}
	}
	while(choice!=4);
	return 0;
}
