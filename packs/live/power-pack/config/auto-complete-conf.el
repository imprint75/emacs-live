(live-add-pack-lib "auto-complete")
(setq live-auto-complete-dir (concat live-packs-dir "live/power-pack/lib/auto-complete"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat live-auto-complete-dir "dict"))
(ac-config-default)
(require 'auto-complete)
