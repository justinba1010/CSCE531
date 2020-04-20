-- Haskell data types for the abstract syntax.
-- Generated by the BNF converter.

module AbsCPP where

newtype Id = Id String
  deriving (Eq, Ord, Show, Read)

data Program = PDefs [Def]
  deriving (Eq, Ord, Show, Read)

data Def = DFun Type Id [Arg] [Stm]
  deriving (Eq, Ord, Show, Read)

data Arg = ADecl Type Id
  deriving (Eq, Ord, Show, Read)

data Stm
    = SExp Exp
    | SDecls Type [Id]
    | SInit Type Id Exp
    | SReturn Exp
    | SReturnVoid
    | SWhile Exp Stm
    | SBlock [Stm]
    | SIfElse Exp Stm Stm
    | SPrintInt Exp
    | SPrintDouble Exp
  deriving (Eq, Ord, Show, Read)

data Exp
    = SReadInt
    | SReadDouble
    | ETrue
    | EFalse
    | EInt Integer
    | EDouble Double
    | EString String
    | EId Id
    | EApp Id [Exp]
    | EPIncr Exp
    | EPDecr Exp
    | EIncr Exp
    | EDecr Exp
    | ETimes Exp Exp
    | EDiv Exp Exp
    | EPlus Exp Exp
    | EMinus Exp Exp
    | ELt Exp Exp
    | EGt Exp Exp
    | ELtEq Exp Exp
    | EGtEq Exp Exp
    | EEq Exp Exp
    | ENEq Exp Exp
    | EAnd Exp Exp
    | EOr Exp Exp
    | EAss Exp Exp
    | ETyped Exp Type
    | VInteger Integer
    | VDouble Double
    | VString String
    | VVoid
    | VUndefined
  deriving (Eq, Ord, Show, Read)

data Type
    = Type_bool | Type_int | Type_double | Type_void | Type_string
  deriving (Eq, Ord, Show, Read)

