{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE EmptyDataDecls    #-}
{-# LANGUAGE RebindableSyntax, OverloadedStrings #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Fay.Underscore where

import Fay.FFI
import Fay.Text

data Template
type Name = Text

-- | 'precompile' corresponds to '_.template' in underscore and takes the name
-- of a <script type="text/template" id="myname-template"> and returns an anonymous
-- function to call when acutally rendering the view with data.
-- Note the following convention: 'Name' is used as prefix to the DOM element id,
-- as well as the variable name inside the template.
precompile :: Name ->
              -- ^ name of the template
              Fay Template
              -- ^ a wrapper for an anonymuous JS function to be called with data
precompile =
  ffi "_.template(jQuery('#' + %1 + '-template').html(), { variable: %1 })" 


-- | 'render' a pre-compiled underscore template with given data.
render :: Automatic a ->
          -- ^ data object to render
          Template  ->
          -- ^ precompiled underscore template
          Fay Text
          -- ^ rendered view with interpolated values
render = ffi "%2['call'](window,%1)"
