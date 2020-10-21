%{

int COMMENT= 0;
int n_line = 1;

void yyerror(char const *s, char *yytext) {
      fprintf(stderr, "line %d: %s %s\n", n_line, s, yytext);
}

%}

id [a-zA-Z][a-zA-Z0-9]*

%%

\n                      {n_line++; printf("\n");} 

#.*                     {printf("\n%s PREPROCESS\n\n",yytext);}

"/*"                    {COMMENT=1;}
"*/"                    {COMMENT=0;}
"//".*                  {}

\{                      {if(!COMMENT) printf("LBRACE");}
\}                      {if(!COMMENT) printf("RBRACE");}

\( 	                  {if(!COMMENT) printf(" LPAREN ");}
\) 	                  {if(!COMMENT) printf(" RPAREN");}

\[                      {if(!COMMENT) printf(" LBRACKET ");}    
\]                      {if(!COMMENT) printf(" RBRACKET");}

\,                      {if(!COMMENT) printf(" COMMA");}
[;]                     {if(!COMMENT) printf(" SEMI");}

\+                      {if(!COMMENT)printf("PLUS ");}
\-                      {if(!COMMENT)printf("MINUS ");}
\/                      {if(!COMMENT)printf("DIV ");}
\%\%                    {if(!COMMENT)printf("MOD ");}
\%                      {if(!COMMENT)printf("PERC ");}
\*                      {if(!COMMENT)printf("STAR ");}
\*\*                    {if(!COMMENT)printf("POW ");}

\+\+                    {if(!COMMENT) printf("INCREMENT+ ");}
\-\-                    {if(!COMMENT) printf("DECREMENT+ ");}

\*=                     {if(!COMMENT) printf("MULT_ASSIGN ");}
\/=                     {if(!COMMENT) printf("DIV_ASSIGN ");}

\&\& |
and                     {if(!COMMENT) printf("AND");}

\|\| |
or	                  {if(!COMMENT) printf("OR");}

\!                      {if(!COMMENT) printf("NOT");}    
\==                     {if(!COMMENT) printf("EQUAL");}
\!=                     {if(!COMMENT) printf("DIFF");}

\<=                     {if(!COMMENT) printf("LESS_EQUAL_THAN");}
\>=                     {if(!COMMENT) printf("MORE_EQUAL_THAN");}
\<                      {if(!COMMENT) printf("LESS_THAN");}
\>                      {if(!COMMENT) printf("MORE_THAN");} 

=                       {if(!COMMENT) printf("ASSIGN");}

int   |
float |
char  |
double|
long  |
void                    {if(!COMMENT) printf("TYPE(%s)", yytext);}

if                      {if(!COMMENT) printf("IF");}
for                     {if(!COMMENT) printf("FOR");}
while                   {if(!COMMENT) printf("WHILE");}
return                  {if(!COMMENT) printf("RETURN");}

{id}                    {if(!COMMENT) printf("ID(%s)",yytext);}
\".*\"                  {if(!COMMENT) printf("STRING(%s)",yytext);}
[0-9]+                  {if(!COMMENT) printf("NUM(%s)",yytext);}
[+-]?[0-9]+"."[0-9]*    {if(!COMMENT) printf("REAL(%s0)",yytext);}

[^ \t]                  yyerror("Error in Syntax:", yytext);

%%

int main(int argc, char **argv) {

    yylex();
    printf("\nNo. of lines=%d\n", n_line);

}
