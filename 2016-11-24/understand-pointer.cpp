	#include <iostream> 
using namespace std; 
 
int main() 
{ 
    int arr1[3]; 
    int arr2[3]; 
    int arr3[3]; 
    int * ptr; 
    // ptr1是一个指向 int [3] 的指针，即ptr的类型和&arr1的类型是一样的，注意：arr1指向的内存区域定长 
    int ptr1[3][3]={{1,2,3},{1,2,3},{1,2,3}}; 
    // ptr2是一个指向 int * 的指针，即ptr2的类型和&ptr是一样的，注意：ptr指向的内存区域不定长 
    int * ptr2[3]={arr1,arr2,arr3}; 
    // ptr3是一个指向 int [3] 的指针，即ptr3的类型和&arr1的类型是一样的，注意：arr1指向的内存区域定长 
    int(* ptr3)[3]=&arr1; 
    ptr3=ptr1; // 没错，他们的类型相同 
 // ptr3=ptr2;//error 无法从“int *[3]”转换为“int (*)[3] 
 // ptr4是一个指向 int * 的指针，即ptr4的类型和&ptr是一样的，注意：ptr指向的内存区域不定长 
    int ** ptr4; 
    //ptr4=&arr1; //error 无法从“int (*)[3]”转换为“int ** 
    ptr4=ptr2; // 没错，他们的类型相同 
 //ptr4=ptr3; // error 无法从“int (*)[3]”转换为“int ** 
    return 0; 
}