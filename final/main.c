#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"



int main()
{
	//RGB16
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;


	printf( "Function1: Name\n" );

	//Dummy Function. Please refer to the specification of Project 1.
	name();

	printf( "Function2: ID\n" );

	//Dummy Function. Please refer to the specification of Project 1.
	id();

	//Dummy printout. Please refer to the specification of Project 1.
	printf( "Main Function:\n" );
	printf( "*****Print All*****\n" );
	printf( "Team 33\n" );
	printf( "10020101   Anny Hsu\n" );
	printf( "10020107   Michael Lo\n" );
	printf( "10027115   JunRu Wang\n" );
	printf( "ID Summation = 30081006\n" );
	printf( "*****End Print*****\n" );


	printf( "\n***** Please enter p to draw Julia Set animation *****\n" );
	// 等待使用者輸入正確指令
	while(getchar()!='p') {}

	// 清除畫面
	system( "clear" );

	// 打開 Frame Buffer 硬體裝置的Device Node，準備之後的驅動程式呼叫
	fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

	if( fd<0 )
	{	printf( "Frame Buffer Device Open Error!!\n" );	}
	else
	{
		for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {


			drawJuliaSet( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );


			write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );


			lseek( fd, 0, SEEK_SET );
		}


		//Dummy printout. Please refer to the specification of Project 1.

		printf( ".*.*.*.<:: Happy New Year ::>.*.*.*.\n" );
		printf( "by Team 33\n" );
		printf( "10020101   Anny Hsu\n" );
		printf( "10020107   Michael Lo\n" );
		printf( "10020115   JunRu Wang\n" );


		close( fd );
	}


	while(getchar()!='p') {}

	return 0;
}
