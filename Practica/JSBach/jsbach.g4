grammar jsbach;

root : code EOF;

code : instr*;

instr : expr
    | assig
    | createList
    | addList
    | deleteList
    | ifcondition
    | while
    | read
    | play
    | write
    | createProcedure
    | accesProcedure;

expr :
      sizeList
    | accesList
    | '(' expr ')'
    | expr ('*' | '/' | '%') expr
    | expr ('+' | '-' ) expr
    | (NUM | ID | NOTE);

assig : ID '<-' (expr | condition | NOTE);

read : '<?>' ID;

play : '<:>' (NOTE | ID | accesList | '{' listParams '}');

write : '<!>' writable;

writable : (expr | STRING | NOTE)*;

createList : ID '<-' '{' listParams '}';

listParams : (expr | NOTE)*;

accesList : ID'['expr']';

addList : ID '<<' expr;

sizeList : '#'ID;

deleteList : '8<' ID'['expr']';

condition : expr ('=' | '/=' | '<' | '>' | '<=' | '>=') expr;

ifcondition : 'if' condition '|:' code ':|' (elsecondition)?;

elsecondition : 'else' '|:' code ':|';

while : 'while' condition '|:' code ':|';

createProcedure : NAME_PROC parameters '|:' code ':|';

parameters : ID*;

accesProcedure : NAME_PROC parameters2;

parameters2 : (NOTE | expr | accesList | sizeList)*;

NUM : [0-9]+ ;

NOTE : 'A0' | 'B0' | 'C8' | [A-G][1-7]?;

NAME_PROC : [A-Z]([a-zA-Z0-9\u0080-\u00FF] | '_')*;

STRING : '"' ~["]* '"';

ID : [a-z][a-zA-Z0-9]*;

WS : [ \n]+ -> skip;

COMMENT : '~~~' .*? '~~~' -> skip;