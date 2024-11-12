/*
 * CS250
 *
 * simple.y: simple parser for the simple "C" language
 * 
 * (C) Copyright Gustavo Rodriguez-Rivera grr@purdue.edu
 *
 * IMPORTANT: Do not post in Github or other public repository
 */

%token	<string_val> WORD

%token 	NOTOKEN LPARENT RPARENT LBRACE RBRACE LCURLY RCURLY COMA SEMICOLON EQUAL STRING_CONST LONG LONGSTAR VOID CHARSTAR CHARSTARSTAR INTEGER_CONST AMPERSAND OROR ANDAND EQUALEQUAL NOTEQUAL LESS GREAT LESSEQUAL GREATEQUAL PLUS MINUS TIMES DIVIDE PERCENT IF ELSE WHILE DO FOR CONTINUE BREAK RETURN

%union	{
		char   *string_val;
		int nargs;
		int my_nlabel;
	}

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

int yylex();
int yyerror(const char * s);

extern int line_number;
const char * input_file;
char * asm_file;
FILE * fasm;

#define MAX_ARGS 5
int nargs;
char * args_table[MAX_ARGS];

#define MAX_GLOBALS 100
int nglobals = 0;
char * global_vars_table[MAX_GLOBALS];

#define MAX_LOCALS 32
int nlocals = 0;
char *local_vars_table[MAX_LOCALS];

#define MAX_STRINGS 100
int nstrings = 0;
char * string_table[MAX_STRINGS];

char *regStk[]={ "rbx", "r10", "r13", "r14", "r15"};
char nregStk = sizeof(regStk)/sizeof(char*);

char *regArgs[]={ "rdi", "rsi", "rdx", "rcx", "r8", "r9"};
char nregArgs = sizeof(regArgs)/sizeof(char*);

int loop_type = -1;

int top = 0;

int nargs =0;
 
int nlabel = 0;

%}

%%

goal:	program
	;

program :
        function_or_var_list;

function_or_var_list:
        function_or_var_list function
        | function_or_var_list global_var
        | /*empty */
	;

function:
         var_type WORD
         {
		 nlocals = 0;
		 fprintf(fasm, "\t.text\n");
		 fprintf(fasm, ".globl %s\n", $2);
		 fprintf(fasm, "%s:\n", $2);

		 fprintf(fasm, "\t# Save Frame pointer\n");
		 fprintf(fasm, "\tpushq %%rbp\n");
         fprintf(fasm, "\tmovq %%rsp,%%rbp\n");
		 fprintf(fasm, "\tsubq $%d, %%rsp\n", MAX_LOCALS*8);
		 fprintf(fasm, "# Save registers. \n");
		 fprintf(fasm, "# Push one extra to align stack to 16bytes\n");
         fprintf(fasm, "\tpushq %%rbx\n");
		 fprintf(fasm, "\tpushq %%rbx\n");
		 fprintf(fasm, "\tpushq %%r10\n");
		 fprintf(fasm, "\tpushq %%r13\n");
		 fprintf(fasm, "\tpushq %%r14\n");
		 fprintf(fasm, "\tpushq %%r15\n");

	 }
	 LPARENT arguments RPARENT compound_statement
         {
		 fprintf(fasm, "# Restore registers\n");
		 fprintf(fasm, "\tpopq %%r15\n");
		 fprintf(fasm, "\tpopq %%r14\n");
		 fprintf(fasm, "\tpopq %%r13\n");
		 fprintf(fasm, "\tpopq %%r10\n");
		 fprintf(fasm, "\tpopq %%rbx\n");
         fprintf(fasm, "\tpopq %%rbx\n");
		 fprintf(fasm, "\taddq $%d, %%rsp\n", MAX_LOCALS*8);
         fprintf(fasm, "\tleave\n");
		 fprintf(fasm, "\tret\n");
         }
	;

arg_list:
         arg
         | arg_list COMA arg
	 ;

arguments:
         arg_list
	 | /*empty*/
	 ;

arg: var_type WORD {
	if (nlocals < MAX_LOCALS){
		local_vars_table[nlocals] = strdup($2);
		fprintf(fasm, "\tmovq %%%s, -%d(%%rbp)\n", regArgs[nargs], 8*(nlocals+1));
		nargs++;
		nlocals++;
	}
		
};

global_var: 
        var_type global_var_list SEMICOLON;

global_var_list: WORD {
			// check if there is enough space
			if (nglobals < MAX_GLOBALS){
				global_vars_table[nglobals] = strdup($1);
				nglobals++;
				fprintf(fasm, ".data\n .comm %s, 8\n", $1);
			}
			//exit if otherwise
        }
| global_var_list COMA WORD {
			// check if there is enough space
			if (nglobals < MAX_GLOBALS){
				global_vars_table[nglobals] = strdup($3);
				nglobals++;
				fprintf(fasm, " .comm %s, 8\n", $3);
			}
			//exit if otherwise
}
        ;

var_type: CHARSTAR | CHARSTARSTAR | LONG | LONGSTAR | VOID;

assignment:
         WORD EQUAL expression {
			char *id = $<string_val>1;
			int local_var = -1;
			for (int i = 0; i < nlocals; i++){
				if (strcmp(id, local_vars_table[i]) == 0){
					local_var = i;
					break;
				}
			}
			if (local_var != -1){
				//means it is local variable
				//nlocals++;
				fprintf(fasm, "\tmovq %%%s, -%d(%%rbp)\n", regStk[top-1], 8 * (local_var + 1));
				top--;
			} else {
				fprintf(fasm, "\tmovq %%rbx, %s\n", id);
				top = 0;
			}

	
		 }
	 | WORD LBRACE expression RBRACE EQUAL expression
	 ;

call :
         WORD LPARENT  call_arguments RPARENT {
		 char * funcName = $<string_val>1;
		 int nargs = $<nargs>3;
		 int i;
		 fprintf(fasm,"     # func=%s nargs=%d\n", funcName, nargs);
     		 fprintf(fasm,"     # Move values from reg stack to reg args\n");
		 for (i=nargs-1; i>=0; i--) {
			top--;
			fprintf(fasm, "\tmovq %%%s, %%%s\n",
			  regStk[top], regArgs[i]);
		 }
		 if (!strcmp(funcName, "printf")) {
			 // printf has a variable number of arguments
			 // and it need the following
			 fprintf(fasm, "\tmovl    $0, %%eax\n");
		 }
		 fprintf(fasm, "\tcall %s\n", funcName);
		 fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top]);
		 top++;
         }
      ;

call_arg_list:
         expression {
		$<nargs>$=1;
	 }
         | call_arg_list COMA expression {
		$<nargs>$++;
	 }

	 ;

call_arguments:
         call_arg_list { $<nargs>$=$<nargs>1; }
	 | /*empty*/ { $<nargs>$=0;}
	 ;

expression :
         logical_or_expr
	 ;

logical_or_expr:
         logical_and_expr
	 | logical_or_expr OROR logical_and_expr {
			fprintf(fasm, "\t # || \n");
			fprintf(fasm, "\t or %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovne %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmove %%r11, %%%s\n", regStk[top-2]);
			top--;
	 }
	 ;

logical_and_expr:
         equality_expr
	 | logical_and_expr ANDAND equality_expr {
			fprintf(fasm, "\t # && \n");
			fprintf(fasm, "\t and %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovne %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmove %%r11, %%%s\n", regStk[top-2]);
			top--;
	 }
	 ;

equality_expr:
         relational_expr
	 | equality_expr EQUALEQUAL relational_expr {
			fprintf(fasm, "\t # == \n");
			fprintf(fasm, "\t cmpq %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmove %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmovne %%r11, %%%s\n", regStk[top-2]);
			top--;

	 }
	 | equality_expr NOTEQUAL relational_expr {
			fprintf(fasm, "\t # != \n");
			fprintf(fasm, "\t cmpq %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovne %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmove %%r11, %%%s\n", regStk[top-2]);
			top--;
	 }
	 ;

relational_expr:
         additive_expr
	 | relational_expr LESS additive_expr {
			fprintf(fasm, "\t # < \n");
			fprintf(fasm, "\t cmpq %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovl %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmovge %%r11, %%%s\n", regStk[top-2]);
			top--;

	 }
	 | relational_expr GREAT additive_expr {
			fprintf(fasm, "\t # > \n");
			fprintf(fasm, "\t cmpq %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovg %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmovle %%r11, %%%s\n", regStk[top-2]);
			top--;

	 }
	 | relational_expr LESSEQUAL additive_expr {
			fprintf(fasm, "\t # <= \n");
			fprintf(fasm, "\t cmpq %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovle %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmovg %%r11, %%%s\n", regStk[top-2]);
			top--;
	 }
	 | relational_expr GREATEQUAL additive_expr {
			fprintf(fasm, "\t # >= \n");
			fprintf(fasm, "\t cmpq %%%s, %%%s\n", regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\t movq $1, %%r12\n");
			fprintf(fasm, "\t movq $0, %%r11\n");
			fprintf(fasm, "\t cmovge %%r12, %%%s\n", regStk[top-2]);
			fprintf(fasm, "\t cmovl %%r11, %%%s\n", regStk[top-2]);
			top--;
	 }
	 ;

additive_expr:
          multiplicative_expr
	  | additive_expr PLUS multiplicative_expr {
		fprintf(fasm,"\n\t# +\n");
		if (top<nregStk) {
			fprintf(fasm, "\taddq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
	  }
	  | additive_expr MINUS multiplicative_expr
	  {
		fprintf(fasm,"\n\t# -\n");
		if (top<nregStk) {
			fprintf(fasm, "\tsubq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
	  }
	  ;

multiplicative_expr:
          primary_expr
	  | multiplicative_expr TIMES primary_expr {
		fprintf(fasm,"\n\t# *\n");
		if (top<nregStk) {
			fprintf(fasm, "\timulq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
          }
	  | multiplicative_expr DIVIDE primary_expr {
	  	fprintf(fasm, "\n\t # /\n");
		if (top < nregStk) {
			//move numerator into rax
			fprintf(fasm, "\tmovq %%%s, %%rax\n", regStk[top-2]);
			//move 0 into rdx
			fprintf(fasm, "\tmovq $0, %%rdx\n");

			//Sign Extend %rax into %rdx:%rax
			fprintf(fasm,"\tcqto\n");

			//divide on denominator
			fprintf(fasm,"\tidivq %%%s\n", regStk[top-1]);

			fprintf(fasm, "\tmovq %%rax, %%%s", regStk[top-2]);

			top--;
		}
	  
	  }
	  | multiplicative_expr PERCENT primary_expr {
		if (top < nregStk) {
			//move numerator into rax
			fprintf(fasm, "\n\t # %%\n");

			fprintf(fasm, "\tmovq %%%s, %%rax\n", regStk[top-2]);
			//move 0 into rdx
			fprintf(fasm, "\tmovq $0, %%rdx\n");

			//Sign Extend %rax into %rdx:%rax
			fprintf(fasm,"\tcqto\n");

			//divide on denominator
			fprintf(fasm,"\tidivq %%%s\n", regStk[top-1]);

			fprintf(fasm, "\tmovq %%rdx, %%%s", regStk[top-2]);

			top--;
		}

	  }
	  ;

primary_expr:
	  STRING_CONST {
		  // Add string to string table.
		  // String table will be produced later
		  string_table[nstrings]=$<string_val>1;
		  fprintf(fasm, "\t#top=%d\n", top);
		  fprintf(fasm, "\n\t# push string %s top=%d\n",
			  $<string_val>1, top);
		  if (top<nregStk) {
		  	fprintf(fasm, "\tmovq $string%d, %%%s\n", 
				nstrings, regStk[top]);
			//fprintf(fasm, "\tmovq $%s,%%%s\n", 
				//$<string_val>1, regStk[top]);
			top++;
		  }
		  nstrings++;
	  }
          | call
	  | WORD {
		  char * id = $<string_val>1;
		  // ID may be local or global variable
		  // Assume it is a global variable
		  // TODO: Implement also local variables
		  int local_var = -1;
		  for (int i = 0; i < nlocals; i++){
			if (strcmp(id, local_vars_table[i]) == 0){
				local_var = i;
				break;
			}
		  }

		  if (local_var != -1){
			//means it is local variable
			fprintf(fasm, "\tmovq -%d(%%rbp), %%%s\n", 8 * (local_var + 1), regStk[top]);
		  } 
		  else {
			fprintf(fasm, "\tmovq %s, %%%s\n", id, regStk[top]);
		  }
		  top++;
	  }
	  | WORD LBRACE expression RBRACE 
	  | AMPERSAND WORD
	  | INTEGER_CONST {
		  fprintf(fasm, "\n\t# push %s\n", $<string_val>1);
		  if (top<nregStk) {
			fprintf(fasm, "\tmovq $%s,%%%s\n", 
				$<string_val>1, regStk[top]);
			top++;
		  }
	  }
	  | LPARENT expression RPARENT
	  ;

compound_statement:
	 LCURLY statement_list RCURLY
	 ;

statement_list:
         statement_list statement
	 | /*empty*/
	 ;

local_var:
        var_type local_var_list SEMICOLON;

local_var_list: WORD {
			assert(nlocals < MAX_LOCALS);
			local_vars_table[nlocals] = $<string_val>1;
			nlocals++;
		}
        | local_var_list COMA WORD
        ;

statement:
         assignment SEMICOLON
	 | call SEMICOLON { top= 0; /* Reset register stack */ }
	 | local_var
	 | compound_statement
	 | IF LPARENT {
		//act 1
		$<my_nlabel>1=nlabel;
		nlabel++;

	 } expression RPARENT {
	   //act 2
	   fprintf(fasm, "\tcmpq $0, %%rbx\n");
	   fprintf(fasm, "\tje if_false_%d\n", $<my_nlabel>1);
	 }statement {
		//act 3
	   fprintf(fasm, "\tjne if_false_after_else_%d\n", $<my_nlabel>1);
	   fprintf(fasm, "\tif_false_%d:\n", $<my_nlabel>1);
	 }else_optional {
		//act 4
		fprintf(fasm, "\tif_false_after_else_%d:\n", $<my_nlabel>1);
	 }
	 | WHILE LPARENT {
		// act 1
		$<my_nlabel>1=nlabel;
		nlabel++;
		loop_type = 0;
		fprintf(fasm, "while_start_%d:\n", $<my_nlabel>1);
         }
         expression RPARENT {
		// act2
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tje while_end_%d\n", $<my_nlabel>1);
		top--;
         }
         statement {
		// act3
		fprintf(fasm, "\tjmp while_start_%d\n", $<my_nlabel>1);
		fprintf(fasm, "while_end_%d:\n", $<my_nlabel>1);
	 }
	 | DO {
		$<my_nlabel>1=nlabel;
		nlabel++;
		loop_type = 1;
		fprintf(fasm, "do_while_start_%d:\n", $<my_nlabel>1);
	 }statement WHILE LPARENT expression {
		
	 } RPARENT SEMICOLON {
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\t jne do_while_start_%d\n", $<my_nlabel>1);
		top--;
	 }
	 | FOR LPARENT assignment  SEMICOLON {
		$<my_nlabel>1=nlabel;
		nlabel++;
		loop_type = 2;
		fprintf(fasm, "for_start_%d:\n", $<my_nlabel>1);


	 } expression SEMICOLON {
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tje end_for_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\t jmp for_body_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\t inc_%d:\n", $<my_nlabel>1);
		top--;

	 } assignment RPARENT {
		fprintf(fasm, "jmp for_start_%d\n", $<my_nlabel>1);
		fprintf(fasm, "for_body_%d:\n", $<my_nlabel>1);
	 } statement {
		fprintf(fasm, "jmp inc_%d\n", $<my_nlabel>1);
		fprintf(fasm, "\t end_for_%d:\n", $<my_nlabel>1);
	 }
	 | jump_statement
	 ;

else_optional:
         ELSE  statement
	 | /* empty */
         ;

jump_statement:
         CONTINUE SEMICOLON {
			$<my_nlabel>1=nlabel - 2;
			//while
			if (loop_type == 0){
				fprintf(fasm, "\t jmp while_start_%d\n", $<my_nlabel>1);
			//do while
			} else if (loop_type == 1){
				//fprintf(fasm, "\t jmp do_while_start_%d\n", $<my_nlabel>1);
			//for
			} else if (loop_type == 2){
				fprintf(fasm, "\t jmp for_start_%d\n", $<my_nlabel>1);

			}
		 }
	 | BREAK SEMICOLON {

	 }
	 | RETURN expression SEMICOLON {
		 fprintf(fasm, "\tmovq %%rbx, %%rax\n");
		 top = 0;
	 }
	 ;

%%

void yyset_in (FILE *  in_str );

int
yyerror(const char * s)
{
	fprintf(stderr,"%s:%d: %s\n", input_file, line_number, s);
}


int
main(int argc, char **argv)
{
	printf("-------------WARNING: You need to implement global and local vars ------\n");
	printf("------------- or you may get problems with top------\n");
	
	// Make sure there are enough arguments
	if (argc <2) {
		fprintf(stderr, "Usage: simple file\n");
		exit(1);
	}

	// Get file name
	input_file = strdup(argv[1]);

	int len = strlen(input_file);
	if (len < 2 || input_file[len-2]!='.' || input_file[len-1]!='c') {
		fprintf(stderr, "Error: file extension is not .c\n");
		exit(1);
	}

	// Get assembly file name
	asm_file = strdup(input_file);
	asm_file[len-1]='s';

	// Open file to compile
	FILE * f = fopen(input_file, "r");
	if (f==NULL) {
		fprintf(stderr, "Cannot open file %s\n", input_file);
		perror("fopen");
		exit(1);
	}

	// Create assembly file
	fasm = fopen(asm_file, "w");
	if (fasm==NULL) {
		fprintf(stderr, "Cannot open file %s\n", asm_file);
		perror("fopen");
		exit(1);
	}

	// Uncomment for debugging
	//fasm = stderr;

	// Create compilation file
	// 
	yyset_in(f);
	yyparse();

	// Generate string table
	int i;
	for (i = 0; i<nstrings; i++) {
		fprintf(fasm, "string%d:\n", i);
		fprintf(fasm, "\t.string %s\n\n", string_table[i]);
	}

	fclose(f);
	fclose(fasm);

	return 0;
}


