

module AbsJ where

-- Haskell module generated by the BNF converter




data Prg = Program [Exp]
  deriving (Eq, Ord, Show, Read)

data Exp
    = EBipush Integer
    | EAdd
    | ESub
    | EDiv
    | EMul
    | EPop
    | EJump Integer
    | EJlt Integer Integer
  deriving (Eq, Ord, Show, Read)

