digits  [0-9]
num [0-9]+(\.[0-9]+)?([Ee][\+|\-]?[0-9]+)?
integer [0-9]+
string  (\".*\"|\'.*\')
divideequal \/=
mulequal   \*=
minusequal  \-= 
equal  =
plusequal \+=
plus	\+
minus	\-
divide	\/
mul	\*
special_start \(
special_end   \)
alpha [a-zA-Z]
%{
#include<stdio.h>
#include"y.tab.h"
#include<string.h>
extern YYSTYPE yylval;
int t = 1;
int n = 0;
%}

%%
#(.*\n) 	 {printf("comment ");return T_COMMENT;} 
(''')(.*\n)*(.*)(''') {printf("comment ");return T_COMMENT;} 

if                      {printf("if ");return T_IF;}
else                    {printf("else ");return T_ELSE;}
while                   {printf("while ");return T_WHILE;}
True                    {printf("True ");yylval=strdup(yytext);return T_T;}
False                   {printf("False ");yylval=strdup(yytext);return T_F;}
{plus}			{printf("plus ");yylval=strdup(yytext);return T_PLUS;}
{minus}			{printf("minus ");return T_MINUS;}
{mul}			{printf("mul ");return T_MUL;}
{divide}		{printf("divide ");return T_DIVIDE;}
{equal}			{printf("equal ");return T_EQUAL;}
{plusequal}		{printf("plusequal ");return T_PLUSEQUAL;}
{divideequal}           {printf("divideequal ");return T_DIVIDEEQUAL;}
{mulequal}              {printf("mulequal ");return T_MULEQUAL;}
{minusequal}            {printf("minusequal ");return T_MINUSEQUAL;}
{special_start}         {printf("special_start ");return T_SPECIAL_START;}
{special_end}           {printf("special_end ");return T_SPECIAL_END;}
\n                      {printf("\n");return T_NL;}
or                    {printf("or ");return T_OR;}
and                    {printf("and ");return T_AND;}
not                     {printf("not ");return T_NOT;}
in                      {printf("in ");return T_IN;}
not\ in                 {printf("not in ");return T_NOTIN;}
\<			{printf("lessthan ");return T_LESSTHAN;}
\<=			{printf("lessthanequal ");return T_LESSTHANEQUAL;}
\>=			{printf("greaterthanequal ");return T_GREATERTHANEQUAL;}
\>			{printf("greaterthan ");return T_GREATERTHAN;}
\==			{printf("doubleequal ");return T_DOUBLEEQUAL;}
\!=			{printf("notequal ");return T_NOTEQUAL;}
:                       {printf("colon ");return T_COLON;}
\[                      {printf("sq bracket start ");return T_SQUAREBRACKET_START;}
\]                      {printf("sq bracket end ");return T_SQUAREBRACKET_END;}
\%                      {printf("mod ");return T_MOD;}
sep			{printf("sep ");return T_SEP;}
end			{printf("end" );return T_END;}
print                   {printf("print ");return T_PRINT;}
range                   {printf("range ");return T_RANGE;}
list			{printf("list ");return T_LIST;}
[a-zA-Z_][_a-zA-Z0-9]*  {printf("ID ");yylval=strdup(yytext);return T_ID;}
{string}                {printf("string ");yylval=strdup(yytext);return T_STRING;}
{integer}               {printf("int ");yylval=strdup(yytext);return T_INTEGER;}
{num}                   {printf("num ");yylval=strdup(yytext);return T_NUM;}
[0-9;!,@#]*/(({alpha}|"_")({alpha}|{digits}|"_")*) 	{printf("%s\t",yytext);}
\'                       {printf("single quote ");return T_SINGLEQUOTE;}
\"                      {printf("double quote ");return T_DOUBLEQUOTE;}
\*\*                    {printf("exp ");return T_EXPONENTIAL;}
,                       {printf("comma ");return T_COMMA;}
\t			{printf("indent ");return T_INDENT;}

%%

int yywrap() {
    return 1;
}

