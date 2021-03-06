// cse9.4-LCS-Output.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include<algorithm>
#include <cstring>
#include <iostream> 
#include <vector> 
#include <string> 
using namespace std;
struct Result
{
	char LCS[100];
};
void reverse(char hex[], int dit)
{
	for (int i = 0; i<dit / 2; i++)
	{
		char temp = hex[i];
		hex[i] = hex[dit - i - 1];
		hex[dit - i - 1] = temp;
	}
}
struct Result LCS(const char text1[], const char text2[])
{
	int V = min(strlen(text1), strlen(text2));
	int N = strlen(text1) + strlen(text2) - V;
	struct Result answer;
	for (int i = 0; i<100; i++)
		answer.LCS[i] = 0;
	vector<vector<int>> track(V+1,vector<int>(N+1));
	vector<vector<int>> f(V + 1, vector<int>(N + 1));
	int len = 0;
	for (int i = 0; i <= V; i++)
		for (int j = 0; j <= N; j++)
		{
			track[i][j] = 0;
			f[i][j] = 0;
		}
	for (int i = 0; i<V; i++)
	{
		for (int j = 0; j<N; j++)
		{
			if (text1[i] == text2[j])
			{
				track[i + 1][j + 1] = 1;
				f[i + 1][j + 1] = f[i][j] + 1;
			}
			else
			{
				if (f[i][j + 1]>=f[i + 1][j])
				{
					f[i + 1][j + 1] = f[i][j + 1];
					track[i + 1][j + 1] = 3;
				}
				else
				{
					f[i + 1][j + 1] = f[i + 1][j];
					track[i + 1][j + 1] = 2;
				}
			}
		}
	}
	//track [0][0...7]
	//track [7][0...7]
	int i=V;
	int j=N;
	while(track[i][j])
	{
	switch(track[i][j])
	{
	case 1:
	{
	answer.LCS[len]=text1[i-1];
	len++;
	i--;
	j--;
	break;
	}
	case 2:
	{
	j--;
	break;
	}
	case 3:
	{
	i--;
	break;
	}
	default:
	break;
	}
	}
	answer.LCS[len]=0;
	reverse(answer.LCS, f[V][N]);
	return answer;
}
#include <iostream> 
using namespace std;

int main() {
	char text1[100];
	char text2[100];
	cin >> text1;
	cin >> text2;
	cout << (LCS(text1, text2)).LCS << endl;
}


