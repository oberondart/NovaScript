#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_VARS 256
#define MAX_VARLEN 256
#define MAX_TOKENS 1024

typedef struct Var {
    char name[MAX_VARLEN];
    char value[MAX_VARLEN];
} Var;

Var varstorage[MAX_VARS];
int var_count = 0;

void set_var(const char *name, const char *value) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(varstorage[i].name, name) == 0) {
            strncpy(varstorage[i].value, value, MAX_VARLEN);
            return;
        }
    }
    strncpy(varstorage[var_count].name, name, MAX_VARLEN);
    strncpy(varstorage[var_count].value, value, MAX_VARLEN);
    var_count++;
}

const char* get_var(const char *name) {
    for (int i = 0; i < var_count; i++) {
        if (strcmp(varstorage[i].name, name) == 0) return varstorage[i].value;
    }
    return NULL;
}

// Tokenizer: splits by spaces and newlines
int tokenize(char *code, char tokens[MAX_TOKENS][MAX_VARLEN]) {
    int count = 0;
    char *tok = strtok(code, " \n\t\r");
    while (tok && count < MAX_TOKENS) {
        strncpy(tokens[count++], tok, MAX_VARLEN);
        tok = strtok(NULL, " \n\t\r");
    }
    return count;
}

// Evaluate a token (literal or variable)
const char* eval_token(const char *tok) {
    const char* val = get_var(tok);
    if(val) return val;
    return tok;
}

// Interpret Nova code (very minimal)
static int l_interpret(lua_State *L) {
    const char *code = luaL_checkstring(L, 1);
    char code_copy[strlen(code)+1];
    strcpy(code_copy, code);

    char tokens[MAX_TOKENS][MAX_VARLEN];
    int tcount = tokenize(code_copy, tokens);

    int i = 0;
    while (i < tcount) {
        if (strcmp(tokens[i], "let") == 0) {
            // let var value
            char *name = tokens[++i];
            char *value = tokens[++i];
            set_var(name, eval_token(value));
            i++;
        }
        else if (strcmp(tokens[i], "out") == 0) {
            const char *val = eval_token(tokens[++i]);
            printf("%s\n", val);
            i++;
        }
        else if (strcmp(tokens[i], "if") == 0) {
            // if var = value { ... } else { ... }
            char *var = tokens[++i];
            char *op = tokens[++i]; // expect "="
            char *val = tokens[++i];
            int condition = 0;
            const char* v = get_var(var);
            if(v && strcmp(op,"=")==0 && strcmp(v,val)==0) condition = 1;

            // Skip "{" (assume always present)
            i++;
            int start_if = i;
            int end_if = start_if;
            int brace = 1;
            while (i < tcount && brace>0) {
                if (strcmp(tokens[i], "{") == 0) brace++;
                else if (strcmp(tokens[i], "}") == 0) brace--;
                i++;
            }
            end_if = i -1;

            // Check for else
            int has_else = 0;
            int start_else = 0, end_else = 0;
            if(i < tcount && strcmp(tokens[i], "else") == 0) {
                i++; // skip else
                i++; // skip {
                has_else = 1;
                start_else = i;
                brace = 1;
                while (i < tcount && brace>0) {
                    if (strcmp(tokens[i], "{") == 0) brace++;
                    else if (strcmp(tokens[i], "}") == 0) brace--;
                    i++;
                }
                end_else = i-1;
            }

            // Execute the chosen block
            int s,e;
            if(condition){ s=start_if; e=end_if;}
            else if(has_else){ s=start_else; e=end_else;}
            else { continue; }

            // simple execution inside block
            int j=s;
            while(j<e){
                if(strcmp(tokens[j],"let")==0){
                    set_var(tokens[j+1], eval_token(tokens[j+2]));
                    j+=3;
                } else if(strcmp(tokens[j],"out")==0){
                    printf("%s\n", eval_token(tokens[j+1]));
                    j+=2;
                } else j++;
            }
        } else i++;
    }

    return 0;
}

// Lua module registration
int luaopen_nova(lua_State *L) {
    static const struct luaL_Reg nova[] = {
        {"interpret", l_interpret},
        {NULL, NULL}
    };
    luaL_newlib(L, nova);
    return 1;
}
