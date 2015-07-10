import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.UpdatePointer
import XMonad.Actions.PhysicalScreens
import XMonad.Util.EZConfig
import XMonad.Util.Paste
import XMonad.Layout.NoBorders

myModMask = mod1Mask
myFloatMask = composeAll [
	className =? "qemu" --> doFloat
	]

myKeys =
  -- Use Custom Screen Maps 
  [((myModMask .|. mask, key), f sc)
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [1, 2, 0]
      , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

main = 
    xmonad $ gnomeConfig
    {
	manageHook = myFloatMask <+> manageHook gnomeConfig, 
	modMask = myModMask,
        logHook = updatePointer $ Relative 0.5 0.5,
	layoutHook = smartBorders (layoutHook gnomeConfig)
    }
    `additionalKeys` myKeys
