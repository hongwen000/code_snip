#ifndef H_TOKEN_H
#define H_TOKEN_H value
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <cstring>


char* itoa(int value, char* result, int base);
#ifndef VAR
typedef enum {
    ERROR = 256,
    ID = 258,
    VAR,
    NUM,
    PRINT,
    PRINT_ALL,
    ADD,
    SUB,
    MUL,
    LPAREN,
    RPAREN,
    DERIVE,
    EXP,
    ASSIGN,
    EQUAL
} TOKEN_TYPE;
#endif

static const char* token_strs[] = {
    "ID",
    "VAR",
    "NUM",
    "PRINT",
    "PRINT_ALL",
    "ADD",
    "SUB",
    "MUL",
    "LPAREN",
    "RPAREN",
    "DERIVE",
    "EXP",
    "ASSIGN",
    "EQUAL"
};

#define YYSTYPE char *

typedef struct
{
    int type;
    std::string lval;
} TOKEN;

extern YYSTYPE yylval;

extern "C" {
    extern int yylex(void);
    extern int yyparse(void);
}


TOKEN getToken ();
void printToken(TOKEN token);
void scan(std::string str);

#endif /* ifndef H_TOKEN_H */
