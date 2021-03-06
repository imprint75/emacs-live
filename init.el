;; Emacs LIVE
;;
;; This is where everything starts. Do you remember this place?
;; It remembers you...

(add-to-list 'command-switch-alist
             (cons "--live-safe-mode"
                   (lambda (switch)
                     nil)))

(setq live-safe-modep
      (if (member "--live-safe-mode" command-line-args)
          "debug-mode-on"
        nil))

(setq live-supported-emacsp t)

(when live-supported-emacsp

;; Store live base dirs
(setq live-root-dir user-emacs-directory)
(setq
 live-tmp-dir      (file-name-as-directory (concat live-root-dir "tmp"))
 live-etc-dir      (file-name-as-directory (concat live-root-dir "etc"))
 live-lib-dir      (file-name-as-directory (concat live-root-dir "lib"))
 live-packs-dir    (file-name-as-directory (concat live-root-dir "packs"))
 live-autosaves-dir(file-name-as-directory (concat live-tmp-dir  "autosaves"))
 live-backups-dir  (file-name-as-directory (concat live-tmp-dir  "backups"))
 live-load-pack-dir nil)

;; create tmp dirs if necessary
(make-directory live-etc-dir t)
(make-directory live-tmp-dir t)
(make-directory live-autosaves-dir t)
(make-directory live-backups-dir t)

;; Load manifest
(load-file (concat live-root-dir "manifest.el"))

;; load live-lib
(load-file (concat live-lib-dir "live-core.el"))

;;default live packs
(let* ((live-dir (file-name-as-directory "live")))
  (setq live-packs (list (concat live-dir "foundation-pack")
                         (concat live-dir "clojure-pack")
                         (concat live-dir "lang-pack")
                         (concat live-dir "power-pack"))))

;; Helper fn for loading live packs

(defun live-version ()
  (interactive)
  (if (called-interactively-p 'interactive)
      (message "%s" (concat "This is Emacs Live " live-version))
    live-version))


;; Load `~/.emacs-live.el`. This allows you to override variables such
;; as live-packs (allowing you to specify pack loading order)
;; Does not load if running in safe mode
(let* ((pack-file (concat (file-name-as-directory "~") ".emacs-live.el")))
  (if (and (file-exists-p pack-file) (not live-safe-modep))
      (load-file pack-file)))

;; Load all packs - Power Extreme!
(mapcar (lambda (pack-dir)
          (live-load-pack pack-dir))
        (live-pack-dirs))

)

;; ############ TEMPORARY ##  gotta figure out where to put this
;; remap C-x C-b to show buffers in current window
(load-theme 'tsdh-dark t)
(global-set-key (kbd "C-x C-b") 'buffer-menu)
;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "<f12>") 'buffer-menu)
(global-set-key (kbd "<f11>") 'switch-to-buffer)
(global-set-key (kbd "<f10>") 'kill-buffer)
(global-set-key (kbd "<f9>") 'goto-line)
(global-set-key (kbd "<f8>") 'linum-mode)
(global-set-key (kbd "<f7>") 'bury-buffer)
(global-set-key (kbd "<f2>") 'sr-speedbar-toggle)
(global-set-key (kbd "<f1>") 'other-window)
;; switch to html mode
(global-set-key (kbd "<C-f10>") 'html-mode)
;; switch to javascript mode when working on inline js in html file
(global-set-key (kbd "<C-f11>") 'js-mode)

;; enable line numbers by default and add a space after the number
(global-linum-mode)
(setq linum-format "%d ")

;; set the window title to be filename and path
;; (setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))
(setq frame-title-format '("Emacs @ " ": %b %+%+ %f"))
