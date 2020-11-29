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

	queue[queueLen] = 0;
	queueLen++;
	visited[0] = 1;

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


}