/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DIGITS = 258,
    ID = 259,
    PLUS = 260,
    MINUS = 261,
    MUL = 262,
    DIVIDE = 263,
    NUM = 264,
    STRING = 265,
    INTEGER = 266,
    SPECIAL = 267,
    NL = 268,
    SPACE = 269,
    KEYWORD = 270,
    SPECIAL_START = 271,
    SPECIAL_END = 272,
    IF = 273,
    ELSE = 274,
    WHILE = 275,
    SEP = 276,
    END = 277,
    OR = 278,
    AND = 279,
    NOT = 280,
    IN = 281,
    NOTIN = 282,
    T = 283,
    F = 284,
    COLON = 285,
    SEMICOLON = 286,
    SQUAREBRACKET_START = 287,
    SQUAREBRACKET_END = 288,
    MOD = 289,
    EQUAL = 290,
    PLUSEQUAL = 291,
    PRINT = 292,
    COMMENT = 293,
    RANGE = 294,
    SINGLEQUOTE = 295,
    DOUBLEQUOTE = 296,
    EXPONENTIAL = 297,
    COMMA = 298,
    INDENT = 299,
    LIST = 300,
    DIVIDEEQUAL = 301,
    MINUSEQUAL = 302,
    MULEQUAL = 303,
    LESSTHAN = 304,
    LESSTHANEQUAL = 305,
    GREATERTHAN = 306,
    GREATERTHANEQUAL = 307,
    DOUBLEEQUAL = 308,
    NOTEQUAL = 309
  };
#endif
/* Tokens.  */
#define DIGITS 258
#define ID 259
#define PLUS 260
#define MINUS 261
#define MUL 262
#define DIVIDE 263
#define NUM 264
#define STRING 265
#define INTEGER 266
#define SPECIAL 267
#define NL 268
#define SPACE 269
#define KEYWORD 270
#define SPECIAL_START 271
#define SPECIAL_END 272
#define IF 273
#define ELSE 274
#define WHILE 275
#define SEP 276
#define END 277
#define OR 278
#define AND 279
#define NOT 280
#define IN 281
#define NOTIN 282
#define T 283
#define F 284
#define COLON 285
#define SEMICOLON 286
#define SQUAREBRACKET_START 287
#define SQUAREBRACKET_END 288
#define MOD 289
#define EQUAL 290
#define PLUSEQUAL 291
#define PRINT 292
#define COMMENT 293
#define RANGE 294
#define SINGLEQUOTE 295
#define DOUBLEQUOTE 296
#define EXPONENTIAL 297
#define COMMA 298
#define INDENT 299
#define LIST 300
#define DIVIDEEQUAL 301
#define MINUSEQUAL 302
#define MULEQUAL 303
#define LESSTHAN 304
#define LESSTHANEQUAL 305
#define GREATERTHAN 306
#define GREATERTHANEQUAL 307
#define DOUBLEEQUAL 308
#define NOTEQUAL 309

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
