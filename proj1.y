%{
	#include<stdio.h>
	#include<stdlib.h>
	int v = 1;
	#include<string.h>
	#include<math.h>
	#include <ctype.h>
	#define null 0
	int size = 0;
	int g = 0;
	void insert(char* l,char* t,int v,char* s,int ln);
	int search(char lab[]);
	void display();
	int yyerror();
	int var = 0;
	int yylex(void);
	int lineno = 1;
	struct symbtab
	{
		int val;
		char label[20];
		char type[20];
		int value;
		char scope[20];
		int lineno;
		struct symbtab *next;
	};
	int error = 0;
	struct symbtab *first,*last,*temp;
	char* op;
%}

%token T_DIGITS T_ID T_PLUS T_MINUS T_MUL T_DIVIDE T_NUM T_STRING T_INTEGER T_SPECIAL T_NL T_SPACE T_KEYWORD T_SPECIAL_START T_SPECIAL_END T_IF T_ELSE T_WHILE T_SEP T_END T_OR T_AND T_NOT T_IN T_NOTIN T_T T_F T_COLON T_SQUAREBRACKET_START T_SQUAREBRACKET_END T_MOD T_EQUAL T_PLUSEQUAL T_PRINT T_COMMENT T_RANGE T_SINGLEQUOTE T_DOUBLEQUOTE T_EXPONENTIAL T_COMMA T_INDENT T_LIST T_DIVIDEEQUAL T_MINUSEQUAL T_MULEQUAL T_LESSTHAN T_LESSTHANEQUAL T_GREATERTHAN T_GREATERTHANEQUAL T_DOUBLEEQUAL T_NOTEQUAL

%%
    P		: S		
    		;		
    S		: Simple S 		
                | Compound S		
                | comment S 
                | T_INDENT Simple S 	{g=0;}
                |
                ;
    Simple      :Assignment LB 			
		|Print LB
		;
    Assignment  : T_ID opassgn E1 	{
    						temp = search($1);
    						if(temp != NULL){
    							var = temp->value;
	    						if($2==1){
	    							var/=$3;
	    						}
	    						if($2==2){
	    							var*=$3;
	    						}
	    						if($2==3){
	    							var-=$3;
	    						}
	    						if(g==1){
	    							insert($1,"IDENTIFIER",var,"local",lineno);
	    							g = 0;
	    						}
	    						else {
	    							insert($1,"IDENTIFIER",var,"global",lineno);
	    						}
	    							
    						}
    						else{
    							printf("\n------------------ERROR : %s Undeclared at line number %d--------------------\n",$1,lineno);
    							error = 1;
    						}
    						
    					}
		| T_ID T_EQUAL E1		{
						if(g==1){
	    							insert($1,"IDENTIFIER",$3,"local",lineno);
	    							g = 1;
	    						}
	    						else{
	    							insert($1,"IDENTIFIER",$3,"global",lineno);
	    						}
						//printf("inserted-----------\n");
					}
		| T_ID T_PLUSEQUAL E1	{
    						temp = search($1);
    						if(temp != NULL){
	    						var = temp->value;
	    						var += $3;
	    						if(g==1){
	    							insert($1,"IDENTIFIER",var,"local",lineno);
	    							g = 0;
	    						}
	    						else{
	    							insert($1,"IDENTIFIER",var,"global",lineno);
	    						}
    						}
    						else{
    							printf("\n------------------ERROR : %s Undeclared at line number %d--------------------\n",$1,lineno);
    							error = 1;
    						}
    						
    					}
		| list
		| string
		; 
    opassgn	: T_DIVIDEEQUAL		{$$=1;}
    		| T_MULEQUAL		{$$=2;}
    		| T_MINUSEQUAL		{$$=3;}
    		;
    list	: T_ID T_EQUAL Arr		
		| T_ID T_PLUSEQUAL Arr	
		;
    Arr		: T_SQUAREBRACKET_START list T_SQUAREBRACKET_END 
		| T_LIST T_SPECIAL_START Range T_SPECIAL_END   
		| T_SQUAREBRACKET_START list T_SQUAREBRACKET_END mul 
		| T_SQUAREBRACKET_START list T_SQUAREBRACKET_END add 
		;
    mul		: T_MUL T_INTEGER  
		;
    add		: T_PLUS T_INTEGER 
		;
    
    list	: listnum
		| liststr
		;
    Range	: T_RANGE T_SPECIAL_START start T_COMMA stop T_COMMA step T_SPECIAL_END 
		| T_RANGE T_SPECIAL_START T_COMMA T_COMMA T_SPECIAL_END  
		;
    start	: T_NUM		
		| T_INTEGER 	
		;
    stop	: T_NUM		
		| T_INTEGER	
		;
    step	: T_NUM		
		| T_INTEGER	
		;
    listnum	: T_NUM T_COMMA listnum		
		| T_INTEGER T_COMMA listnum	
		| T_NUM				
		| T_INTEGER			
		;
    liststr	: Str T_COMMA liststr		
		| Str
		;
    Str		: T_STRING 			
		| T_STRING mul			
		| T_STRING addstr			
		;
    addstr	: T_PLUS T_STRING			
		;

    string	: T_ID T_EQUAL T_STRING		
		| T_ID T_PLUSEQUAL T_STRING 		
		;	
    
    E1		: E1 OP1 E2 	{
    					if($2==1)
    						{$$=$1+$3;}
    					else if($2==2)
    						{$$=$1-$3;}
    				}
                | E2
		;
    E2		: E2 OP2 E3 	{
    					if($2==3)
    						{$$=$1*$3;}
    					else if($2==4)
    						{$$=$1/$3;}
    				}
                | E3
		;
    E3		: E4 T_EXPONENTIAL E3 	
                | E4
		;
    E4		: T_NUM 				{$$=atoi($1);}
		| T_INTEGER			{$$=atoi($1);}
                | T_ID 				{
                					temp = search($1);
                					if(temp != NULL){
                						var = temp->value;
                						$$ = var;
                					}
                					else{
                						printf("\n------------------ERROR : %s Undeclared at line number %d--------------------\n",$1,lineno);
    								error = 1;
                					}	
                					
                				}
                |T_SPECIAL_START E1 T_SPECIAL_END	{$$=$2;}
                
		;
    OP1		: T_PLUS				{$$=1;}	
		| T_MINUS				{$$=2;}
		;	
    OP2		: T_MUL				{$$=3;}
		| T_DIVIDE			{$$=4;}
		;

    Compound    : if_else LB
		| only_if LB	
		| while_loop LB
		;

    if_else     : T_IF condition T_COLON LB T_IND else_1 	
		;
    only_if	: T_IF condition T_COLON LB T_IND	
		;
    else_1	: T_ELSE T_COLON LB T_IND 
		;
    while_loop	: T_WHILE condition T_COLON LB T_IND
		;
    condition	: cond 
		;		
    cond        : cond opor cond1 	
		| cond1
		;
    cond1	: cond1 opand cond2 
		| cond2
		;
    cond2       : opnot cond2 
		| cond3
		;
    cond3 	: T_SPECIAL_START cond T_SPECIAL_END
		| relexp 
		| bool
		;
    relexp 	: relexp relop E1  
		| T_ID 		
		| T_NUM   		
		| T_INTEGER	
		;
    relop       : comparison 			
    		| T_IN 
    		| T_NOTIN
    		;
    comparison	: T_LESSTHAN			
    		| T_LESSTHANEQUAL			
    		| T_GREATERTHAN			
    		| T_GREATERTHANEQUAL		
    		| T_DOUBLEEQUAL			
    		| T_NOTEQUAL			
    		;
    bool       	: T_T 
    		| T_F
		;
    opor        : T_OR	
		;
    opand       : T_AND
		;
    opnot       : T_NOT 
		;

    T_IND       : T_INDENT A S	
		;
    A		:		{g=1;}
    		;
    		
    Print 	: T_PRINT T_SPECIAL_START toprint T_SPECIAL_END
		| T_PRINT T_SPECIAL_START toprint T_SEP T_EQUAL T_STRING T_END T_EQUAL T_STRING T_SPECIAL_END
		| T_PRINT T_SPECIAL_START toprint T_SEP T_EQUAL T_STRING T_SPECIAL_END
		| T_PRINT T_SPECIAL_START toprint T_END T_EQUAL T_STRING T_SPECIAL_END
		;
    
    toprint	: X
		| X T_COMMA toprint
		;
    X		: T_STRING
		| Arr
		| T_ID		
		| T_NUM			
		| T_INTEGER	
		;
   comment	: T_COMMENT 	{lineno += 1;}
   LB		: T_NL		{lineno += 1;}
   
  
%%

int yyerror(){
        printf("\n------------------SYNTAX ERROR : at line number %d -------------------------\n",lineno);
    	error = 1;
	v=0;
        return 0;
}
 void insert(char* l,char* t,int v,char* s,int ln)
{
	struct symbtab *n;
	n=search(l);
	if(n!=NULL)
        {
              	n->value = v;
              	n->lineno = ln;
              	strcpy(n->scope,s);  
        }
        else
        {
        	struct symbtab *p;
                p=malloc(sizeof(struct symbtab));
                strcpy(p->label,l);
                strcpy(p->type,t);
                p->value = v;
                p->lineno = ln;
                strcpy(p->scope,s);
                p->next=null;
                if(size==0)
                {
		        first=p;
		        last=p;
                }
                else
                {
                        last->next=p;
                        last=p;
                }
                size++;
        }
}

void display()
{
        int i;
        struct symbtab *p;
        p=first;
        printf("\n------------------SYMBOL TABLE----------------\n");
        printf("----------------------------------------------\n");
        printf("LABEL\tTYPE\t\tVALUE\tSCOPE\tLINENO\n");
        for(i=0;i<size;i++)
        {
                printf("%s\t%s\t%d\t%s\t%d\n",p->label,p->type,p->value,p->scope,p->lineno);
                p=p->next;
        }
}
int search(char lab[])
{
        int i=0;
        struct symbtab *p,*flag;
        p=first;
        for(i=0;i<size;i++)
        {
                if(strcmp(p->label,lab)==0)
                {
                	flag=p;
                	return flag;
                }
                p=p->next;
        }
        p=NULL;
        return p;
}
int main(){
         extern FILE* yyin;
	 yyin = fopen("inp.py","r");
	 yyparse();
	 if(v)
	 {
	    printf("------------------------------PARSE SUCCESSFUL---------------------------\n");
	 }
	 if(!error){
	 	display();
	 }
	 return 1;
	
}
