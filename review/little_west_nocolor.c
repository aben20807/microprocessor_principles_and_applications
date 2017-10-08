#include <stdio.h>
#include <stdlib.h>

#define MALLOC(p, s) \
		if(!((p) = malloc(s))){ \
			fprintf(stderr, "insufficient memory"); \
			exit(EXIT_FAILURE); \
		}
int dataSize;

typedef struct element* elementPtr;
struct element {
    char data;
    elementPtr next;
};
elementPtr head;

typedef struct stack* stack_p;
struct stack {
    char memory[256];
};
stack_p stackHead;
int stackPointer;

void push(char data) {
    stackHead -> memory[stackPointer++] = data;
    printf("push %c\n", data);
}

void pop() {
    if(stackPointer == 0){
        printf("nothing in stack!\n");
        return;
    }
    char tmp = stackHead -> memory[--stackPointer];
    printf("pop %c\n", tmp);
}

void printStack() {
    printf("┌────────────────────\n");
    printf("│ Stack: ");
    for(int i = 0; i < stackPointer; i++){
        printf("%c", stackHead -> memory[i]);
    }
    printf("\n│ stack pointer: %d\n", stackPointer);
    printf("└────────────────────\n");
}

void initData() {
    printf("data size: %lu byte\n", sizeof(head -> data));
    MALLOC(head, sizeof(*head));
    head -> data = 'a';
    head -> next = NULL;
    elementPtr current = head;
    for(int i = 1; i < 50; i++){
        MALLOC(current -> next, sizeof(*head));
        current = current -> next;
        current -> data = (char)('a' + (i % 26));
        current -> next = NULL;
    }
    dataSize = 50;
}

void printData() {
    if(head == NULL){
        printf("No data!\n");
        return;
    }
    printf("┌────────────────────\n");
    printf("│ Data: ");
    elementPtr current = head;
    for(int i = 0; i < dataSize; i++){
        printf("%c", current -> data);
        current = current -> next;
    }
    printf("\n│ data number: %d\n", dataSize);
    printf("└────────────────────\n");
}

void pushDataToStack(int n) {
    if(head == NULL){
        printf("No data!\n");
        return;
    }
    else if(n >= dataSize){
        printf("Out of data range!\n");
        return;
    }
    if(n == 0){
        elementPtr tmp = head;
        head = head -> next;
        push(tmp -> data);
        free(tmp);
        dataSize--;
        return;
    }
    elementPtr current = head;
    for(int i = 0; i < (n-1); i++){
        current = current -> next;
    }
    elementPtr tmp = current -> next;
    current -> next = current -> next -> next;
    push(tmp -> data);
    free(tmp);
    dataSize--;
    return;
}


int main(int argc, char *argv[]) {
    MALLOC(stackHead, sizeof(*stackHead));
    stackPointer = 0;
    initData();
    while(1){
        printData();
        printStack();
        printf("pop(0, push(1, exit(-1\n");
        int command;
        scanf("%d", &command);
        if(command == 0){
            pop();
        }
        else if(command == 1){
            printf("push data: ");
            int n;
            scanf("%d", &n);
            pushDataToStack(n);
        }
        else if(command == -1){
            printf("exit\n");
            break;
        }
        else{
            printf("Wrong command!\n");
            continue;
        }
    }
    return 0;
}
