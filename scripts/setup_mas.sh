#!/usr/bin/env bash

APPS=(
  425424353    # The Unarchiver
  472226235    # LanScan
  640199958    # Developer
  803453959    # Slack
  899247664    # TestFlight
  1388020431   # DevCleaner for Xcode
  1432731683   # Adblock Plus
  1457450145   # Octotree
  1463298887   # Userscripts
  1477385213   # Save to Pocket
  1480933944   # Vimari
  1487937127   # Craft
  1496833156   # Playgrounds
  1533805339   # Keepa - Price Tracker
  1547912640   # uBlacklist for Safari
)

if [ $HOMEBREW_WORK ]; then
  APPS+=(
    412448059   # ForkLift
    1295203466  # Microsoft Remote Desktop
    1449412482  # Reeder 4
  )
else
  APPS+=(
    411643860   # DaisyDisk
    445189367   # PopClip
    409183694   # Keynote
    409203825   # Numbers
    411643860   # DaisyDisk
    445189367   # PopClip
    494803304   # WiFi Explorer
    1289583905  # Pixelmator Pro
    1380563956  # 辞書 by 物書堂
    1444383602  # GoodNotes
    1482454543  # Twitter
    1529448980  # Reeder
    1544743900  # Hush
  )
fi

mas install ${APPS[@]}
