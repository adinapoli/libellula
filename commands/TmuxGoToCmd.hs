module TmuxGoToCommand where

import Libellula

cmd :: (T.Text, IO ())
cmd = on "tmux go to" $ \rest -> do
