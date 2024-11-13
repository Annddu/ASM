#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int asmdouble(int num);

#define MAX_SIZE 100

int main() {
    FILE *file = fopen("numbers.txt", "r");
    char s1[MAX_SIZE], s2[MAX_SIZE] = "";
    fgets(s1, MAX_SIZE, file);
    fclose(file);

    int numbers[MAX_SIZE], count = 0;
    char* token = strtok(s1, ", ");
    while (token != NULL) {
        int num = atoi(token);
        int doubled = asmdouble(num);
        numbers[count++] = doubled;
        token = strtok(NULL, ", ");
    }

    for (int i = count - 1; i >= 0; i--) {
        char buffer[10];
        sprintf(buffer, "%d, ", numbers[i]);
        strcat(s2, buffer);
    }

    // Remove the trailing comma and space
    s2[strlen(s2) - 2] = '\0';

    printf("%s\n", s2);

    return 0;
}