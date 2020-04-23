-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParCPP where
import AbsCPP
import LexCPP
import ErrM

}

%name pProgram Program
%name pDef Def
%name pListDef ListDef
%name pArg Arg
%name pListArg ListArg
%name pStm Stm
%name pListStm ListStm
%name pExp15 Exp15
%name pExp14 Exp14
%name pExp13 Exp13
%name pExp12 Exp12
%name pExp11 Exp11
%name pExp9 Exp9
%name pExp8 Exp8
%name pExp4 Exp4
%name pExp3 Exp3
%name pExp2 Exp2
%name pExp Exp
%name pExp1 Exp1
%name pExp5 Exp5
%name pExp6 Exp6
%name pExp7 Exp7
%name pExp10 Exp10
%name pListExp ListExp
%name pType Type
%name pListId ListId
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '!=' { PT _ (TS _ 1) }
  '&&' { PT _ (TS _ 2) }
  '(' { PT _ (TS _ 3) }
  ')' { PT _ (TS _ 4) }
  '*' { PT _ (TS _ 5) }
  '+' { PT _ (TS _ 6) }
  '++' { PT _ (TS _ 7) }
  ',' { PT _ (TS _ 8) }
  '-' { PT _ (TS _ 9) }
  '--' { PT _ (TS _ 10) }
  '/' { PT _ (TS _ 11) }
  ';' { PT _ (TS _ 12) }
  '<' { PT _ (TS _ 13) }
  '<=' { PT _ (TS _ 14) }
  '=' { PT _ (TS _ 15) }
  '==' { PT _ (TS _ 16) }
  '>' { PT _ (TS _ 17) }
  '>=' { PT _ (TS _ 18) }
  'bool' { PT _ (TS _ 19) }
  'double' { PT _ (TS _ 20) }
  'else' { PT _ (TS _ 21) }
  'false' { PT _ (TS _ 22) }
  'if' { PT _ (TS _ 23) }
  'int' { PT _ (TS _ 24) }
  'printDouble(' { PT _ (TS _ 25) }
  'printInt(' { PT _ (TS _ 26) }
  'readDouble()' { PT _ (TS _ 27) }
  'readInt()' { PT _ (TS _ 28) }
  'return' { PT _ (TS _ 29) }
  'string' { PT _ (TS _ 30) }
  'true' { PT _ (TS _ 31) }
  'void' { PT _ (TS _ 32) }
  'while' { PT _ (TS _ 33) }
  '{' { PT _ (TS _ 34) }
  '||' { PT _ (TS _ 35) }
  '}' { PT _ (TS _ 36) }
  L_integ  { PT _ (TI $$) }
  L_doubl  { PT _ (TD $$) }
  L_quoted { PT _ (TL $$) }
  L_Id { PT _ (T_Id $$) }

%%

Integer :: { Integer }
Integer  : L_integ  { (read ( $1)) :: Integer }

Double  :: { Double }
Double   : L_doubl  { (read ( $1)) :: Double }

String  :: { String }
String   : L_quoted {  $1 }

Id :: { Id}
Id  : L_Id { Id ($1)}

Program :: { Program }
Program : ListDef { AbsCPP.PDefs (reverse $1) }
Def :: { Def }
Def : Type Id '(' ListArg ')' '{' ListStm '}' { AbsCPP.DFun $1 $2 $4 (reverse $7) }
ListDef :: { [Def] }
ListDef : {- empty -} { [] } | ListDef Def { flip (:) $1 $2 }
Arg :: { Arg }
Arg : Type Id { AbsCPP.ADecl $1 $2 }
ListArg :: { [Arg] }
ListArg : {- empty -} { [] }
        | Arg { (:[]) $1 }
        | Arg ',' ListArg { (:) $1 $3 }
Stm :: { Stm }
Stm : Exp ';' { AbsCPP.SExp $1 }
    | Type ListId ';' { AbsCPP.SDecls $1 $2 }
    | Type Id '=' Exp ';' { AbsCPP.SInit $1 $2 $4 }
    | 'return' Exp ';' { AbsCPP.SReturn $2 }
    | 'return' ';' { AbsCPP.SReturnVoid }
    | 'while' '(' Exp ')' Stm { AbsCPP.SWhile $3 $5 }
    | '{' ListStm '}' { AbsCPP.SBlock (reverse $2) }
    | 'if' '(' Exp ')' Stm 'else' Stm { AbsCPP.SIfElse $3 $5 $7 }
    | 'printInt(' Exp ')' ';' { AbsCPP.SPrintInt $2 }
    | 'printDouble(' Exp ')' ';' { AbsCPP.SPrintDouble $2 }
ListStm :: { [Stm] }
ListStm : {- empty -} { [] } | ListStm Stm { flip (:) $1 $2 }
Exp15 :: { Exp }
Exp15 : 'readInt()' { AbsCPP.SReadInt }
      | 'readDouble()' { AbsCPP.SReadDouble }
      | 'true' { AbsCPP.ETrue }
      | 'false' { AbsCPP.EFalse }
      | Integer { AbsCPP.EInt $1 }
      | Double { AbsCPP.EDouble $1 }
      | String { AbsCPP.EString $1 }
      | Id { AbsCPP.EId $1 }
      | Id '(' ListExp ')' { AbsCPP.EApp $1 $3 }
      | '(' Exp ')' { $2 }
Exp14 :: { Exp }
Exp14 : Exp15 '++' { AbsCPP.EPIncr $1 }
      | Exp15 '--' { AbsCPP.EPDecr $1 }
      | Exp15 { $1 }
Exp13 :: { Exp }
Exp13 : '++' Exp14 { AbsCPP.EIncr $2 }
      | '--' Exp14 { AbsCPP.EDecr $2 }
      | Exp14 { $1 }
Exp12 :: { Exp }
Exp12 : Exp12 '*' Exp13 { AbsCPP.ETimes $1 $3 }
      | Exp12 '/' Exp13 { AbsCPP.EDiv $1 $3 }
      | Exp13 { $1 }
Exp11 :: { Exp }
Exp11 : Exp11 '+' Exp12 { AbsCPP.EPlus $1 $3 }
      | Exp11 '-' Exp12 { AbsCPP.EMinus $1 $3 }
      | Exp12 { $1 }
Exp9 :: { Exp }
Exp9 : Exp9 '<' Exp10 { AbsCPP.ELt $1 $3 }
     | Exp9 '>' Exp10 { AbsCPP.EGt $1 $3 }
     | Exp9 '<=' Exp10 { AbsCPP.ELtEq $1 $3 }
     | Exp9 '>=' Exp10 { AbsCPP.EGtEq $1 $3 }
     | Exp10 { $1 }
Exp8 :: { Exp }
Exp8 : Exp8 '==' Exp9 { AbsCPP.EEq $1 $3 }
     | Exp8 '!=' Exp9 { AbsCPP.ENEq $1 $3 }
     | Exp9 { $1 }
Exp4 :: { Exp }
Exp4 : Exp4 '&&' Exp5 { AbsCPP.EAnd $1 $3 } | Exp5 { $1 }
Exp3 :: { Exp }
Exp3 : Exp3 '||' Exp4 { AbsCPP.EOr $1 $3 } | Exp4 { $1 }
Exp2 :: { Exp }
Exp2 : Exp3 '=' Exp2 { AbsCPP.EAss $1 $3 } | Exp3 { $1 }
Exp :: { Exp }
Exp : Exp1 { $1 }
Exp1 :: { Exp }
Exp1 : Exp2 { $1 }
Exp5 :: { Exp }
Exp5 : Exp6 { $1 }
Exp6 :: { Exp }
Exp6 : Exp7 { $1 }
Exp7 :: { Exp }
Exp7 : Exp8 { $1 }
Exp10 :: { Exp }
Exp10 : Exp11 { $1 }
ListExp :: { [Exp] }
ListExp : {- empty -} { [] }
        | Exp { (:[]) $1 }
        | Exp ',' ListExp { (:) $1 $3 }
Type :: { Type }
Type : 'bool' { AbsCPP.Type_bool }
     | 'int' { AbsCPP.Type_int }
     | 'double' { AbsCPP.Type_double }
     | 'void' { AbsCPP.Type_void }
     | 'string' { AbsCPP.Type_string }
ListId :: { [Id] }
ListId : Id { (:[]) $1 } | Id ',' ListId { (:) $1 $3 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++
  case ts of
    []      -> []
    [Err _] -> " due to lexer error"
    t:_     -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
}

