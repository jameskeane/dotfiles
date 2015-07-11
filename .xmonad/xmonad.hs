import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.UpdatePointer
import XMonad.Actions.PhysicalScreens
import XMonad.Util.EZConfig
import XMonad.Util.Paste
import XMonad.Layout.NoBorders
import XMonad.Layout.Minimize
import XMonad.Hooks.EwmhDesktops

myModMask = mod1Mask
myFloatMask = composeAll [
	className =? "qemu" --> doFloat,
        className =? "Zenity" --> doFloat
	]

myKeys =
  -- Set up keys for minimizing windows (mostly for steam)
  [
    ((myModMask, xK_m ), withFocused minimizeWindow),
    ((myModMask .|. shiftMask, xK_m ), sendMessage RestoreNextMinimizedWin)
  ]

  ++
  -- Use Custom Screen Maps 
  [((myModMask .|. mask, key), f sc)
      | (key, sc) <- zip [xK_w, xK_e, xK_r] [1, 2, 0]
      , (f, mask) <- [(viewScreen, 0), (sendToScreen, shiftMask)]]

main = 
    xmonad $ ewmh gnomeConfig
    {
	manageHook = myFloatMask <+> manageHook gnomeConfig, 
	modMask = myModMask,
        logHook = updatePointer $ Relative 0.5 0.5,
	layoutHook = minimize $ smartBorders (layoutHook gnomeConfig),
        focusedBorderColor = "#E84C3D",
        normalBorderColor = "#595959"
    }
    `additionalKeys` myKeys
