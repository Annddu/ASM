#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int asmconvert(int digit);

#define MAX_SIZE 100

int extractHundredsPlace(char* s1, char* s2) {
    char* token;
    int size = 0;
    token = strtok(s1, ", ");
        while (token != NULL) {
            int num = atoi(token);
            int hundreds = (num / 100) % 10;
            *s2 = asmconvert(hundreds);
            s2++;
            *s2 = ',';
            s2++;
            *s2 = ' ';
            s2++;
            size += 3;
            token = strtok(NULL, ", ");
        }
        return size;
}

int main() {
    char s1[MAX_SIZE];
    printf("Enter the string s1: ");
    fgets(s1, sizeof(s1), stdin);
    s1[strcspn(s1, "\n")] = '\0'; // Removing newline character from fgets input

    char s2[MAX_SIZE] = ""; // Considering max size of s2

    int size = extractHundredsPlace(s1, s2);
    s2[size - 2] = '\0';

    printf("The string s2: %s\n", s2);

    return 0;
}
