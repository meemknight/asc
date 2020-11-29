#include <stdio.h>

constexpr int SIZE = 11;

int mat[SIZE][SIZE] = {
0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0,
0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0,
0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0,
0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0,
0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0,
0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0,
0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1,
0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0,
};

int roles[SIZE] = {1, 1, 2, 4, 2, 1, 3, 2, 4, 3, 1};

enum 
{
role_host = 1,
role_switch,
role_switchMalitios,
role_controllerLogic
};

const char* roleNames[4] 
{
	"host",
	"switch",
	"switch malitios",
	"controller logic"
};

int main()
{

	for(int i=0;i < SIZE; i++)
	{
		if(roles[i] == role_switchMalitios)
		{
			printf("switch malitios index %d: ", i);
			
			for(int j=0;j <SIZE; j++)
			{
				if(mat[i][j]==1)
				{
					printf("%s index %d; ", roleNames[roles[j]-1], j);
				}
			}

			printf("\n");
	
		}
	
	}


}