#include <iostream>
#include <thread>
#include <mutex>
#include <queue>
#include <atomic>

#ifdef DEBUG
#define DEBUG_PRINTF(x) printf x
#else 
#define DEBUG_PRINTF(x) do{} while(0)
#endif

constexpr int thread_num = 2;

using namespace std::chrono;

std::mutex mut;
std::queue<int> que;
int ins = 0;
int ext = 0;
std::atomic_bool start(false);
void insert(int n)
{ 
    while(!start);
    while(true)
    {
        if(ins == 1000) 
        {
            DEBUG_PRINTF(("Producer %d exiting\n", n));
            break;
        }
        DEBUG_PRINTF(("Producer %d: %d\n", n, ins));
        que.push(ins++);
    }
}
void extract(int n)
{
    while(!start);
    while(true)
    {
        if(ext == 1000) 
        {
            DEBUG_PRINTF(("Consumer %d exiting\n", n));
            break;
        }
        if(que.size())
        {
            int v = que.front();
            que.pop();
            DEBUG_PRINTF(("Consumer %d: %d\n", n, v));
            ++ext;
        }
    }
}
int main()
{
    auto t1 = high_resolution_clock::now();
    start = true;
    insert(0);
    extract(0);
    auto t2 = high_resolution_clock::now();
    auto t = duration_cast<microseconds>(t2-t1).count() ;
    std::cout << "End of run: " << t << " us" << std::endl;
    return 0;
}
