

module AbsNFA where

-- Haskell module generated by the BNF converter




newtype Letter = Letter String deriving (Eq, Ord, Show, Read)
data Exp
    = EExpr Exp
    | ESymbol Letter
    | ESequence Exp Exp
    | EClosure Exp
    | EUnion Exp Exp
  deriving (Eq, Ord, Show, Read)

