{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module HGrep.Lens.Rules where


import           Control.Lens

import           HGrep.Prelude

import           Language.Haskell.TH (Name, DecsQ, mkName, nameBase)


rules :: LensRules
rules =
  lensRules
    & set' lensField namer
    & set' simpleLenses False
    & set' createClass False
    & set' generateSignatures True

namer :: FieldNamer
namer _ _fields field =
  [TopName (mkName ("_" <> nameBase field))]

makeOptics :: Name -> DecsQ
makeOptics tn =
  (<>)
    <$> makeLensesWith rules tn
    <*> makePrisms tn
