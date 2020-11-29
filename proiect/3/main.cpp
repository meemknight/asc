#include <stdio.h>

int main()
{

	constexpr int N = 11;
	int queueLen = 0;
	int queueIdx = 0;
	int queue[100] = {};
	int visited[N] = {};
	int graph[N][N] = 
	{
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
	0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0
	};

	int roles[N] = { 1, 1, 2, 4, 2, 1, 3, 2, 4, 3, 1 };


	int a, b;
	//scanf("%d %d", &a, &b);
	a = 0;
	b = 10;

	queue[queueLen] = a;
	queueLen++;
	visited[a] = 1;

	//remove bad connections
	for (int i = 0; i < N; i++)
	{
		if(roles[i] == 3)
		{
			for(int j=0; j<N;j++)
			{
				graph[i][j] = 0;
				graph[j][i] = 0;
			}
		}
	}


	while (queueIdx != queueLen)
	{
		int currentNode = queue[queueIdx];
		queueIdx++;
		if (roles[currentNode] == 1)
		{
			printf("%d ", currentNode);
		}

		int columnIndex = 0;
		while (columnIndex < N)
		{
			if (graph[currentNode][columnIndex] == 1)
			{
				if (visited[columnIndex] != 1)
				{
					queue[queueLen] = columnIndex;
					queueLen++;
					visited[columnIndex] = 1;
				}
			}
			
			columnIndex++;
		}
				
	}

	if(visited[b])
	{
		printf("safe\n");
	}else
	{
		printf("unsafe\n");
	}


}