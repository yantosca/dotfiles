(setq enable-athena-backend nil)

(setq enable-two-vertical-frames nil)

(setq enable-vterm t)

(org-babel-load-file "~/.emacs.d/emacs-config/elisp/elisp.org")

(org-babel-load-file "~/.emacs.d/emacs-config/elpa/elpa.org")

(setq display-time-day-and-date t)
(setq display-time-string-forms
      (quote
       ((if (and (not display-time-format)
                 display-time-day-and-date)
            (format-time-string "%a %b %e   " now) "  ")
        (format-time-string
         (or display-time-format
             (if display-time-24hr-format "%H:%M" "%-I:%M%p")) now)
        ))
      )
(display-time)

(defun insert-timestamp ()
  "Insert a nicely formatted date string."
  (interactive)
  (insert (format-time-string "!  %e %b %Y - R. Yantosca - ")))

(fset 'macrotimestamp
      [?\M-x ?i ?n ?s ?e ?r ?t ?- ?t ?i ?m ?e ?s ?t tab return return left ? ])

(unless enable-athena-backend
  (when (display-graphic-p)
    (set-face-font
     'default
     {%@@ if profile == "hypnotoad" @@%}
     "-*-DejaVuSansMono-Bold-R-*-*-*-100-*-*-*-*-iso8859-1")))
     {%@@ elif profile == "zoidberg" @@%}
     "-*-DejaVuSansMono-Bold-R-*-*-*-120-*-*-*-*-iso8859-1")))
     {%@@ elif profile == "calculon" @@%}
     "-*-source code pro-Bold-R-*-*-*-160-*-*-*-*-iso8859-1")))
     {%@@ endif @@%}

(unless enable-two-vertical-frames
  (set-frame-height (selected-frame) 41) ;; 40 lines
  (set-frame-width  (selected-frame) 81) ;; 80 cols
)

(when enable-two-vertical-frames
 (set-frame-height (selected-frame) 41)  ;; 40 lines
 (set-frame-width  (selected-frame) 164) ;; 164 cols
 (split-window-horizontally)
)

(setq-default line-number-mode   t)
(setq-default column-number-mode t)

(when (display-graphic-p)
  (set-scroll-bar-mode 'left))

(setq inhibit-splash-screen t)   ;; not working w/ 21.4
(setq inhibit-startup-message t) ;; working w/ 21.4

(setq frame-title-format "%S: %f")

(setq kill-whole-line t)

(setq minibuffer-max-depth nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq visible-bell nil
      ring-bell-function 'flash-mode-line)
(defun flash-mode-line ()
  (invert-face 'mode-line)
  (run-with-timer 0.1 nil #'invert-face 'mode-line))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(column-number-mode t)
 '(current-language-environment "ASCII")
 '(display-time-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages '(better-shell magit yasnippet-classic-snippets))
 '(query-user-mail-address nil)
 '(user-mail-address "yantosca@seas.harvard.edu"))

(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-new-versions 10)
(setq kept-old-versions 2)
(setq version-control t)

(defalias 'omitmod
  (read-kbd-macro "C-u %o.mod RET"))

(fset 'omitdotfiles
      [?% ?m ?^ ?\\ ?. ?. ?* return ?k])

(fset 'omit-fortran
      [?% ?m ?^ ?\\ ?. ?\\ ?| ?\\ ?. ?o ?$ ?\\ ?| ?\\ ?. ?m ?o ?d ?$ ?\\ ?| ?~ ?$ return ?k])

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(defalias 'quitnclean
  (read-kbd-macro "C-c C-\\ C-c C-o"))

(defalias 'swapbuffer
  (read-kbd-macro "C-x b RET"))

(global-set-key [f10] 'swapbuffer)
(global-set-key [f11] 'switch-to-buffer)
(global-set-key [f12] 'kill-this-buffer)

(global-set-key [(delete)]            "\C-d")
(global-set-key [(control delete)]    'kill-word)
(global-set-key [(control backspace)] 'backward-kill-word)
(delete-selection-mode t)

(global-set-key [(shift f1)] 'ediff-files)
(global-set-key [(shift f2)] 'ediff-buffers)
(global-set-key [(shift f3)] 'fullcleanediff)

(global-set-key [f1]               'kill-line)
(global-set-key [f2]               'kill-word)
(global-set-key [f3]               'string-rectangle)
(global-set-key [f4]               'delete-rectangle)
(global-set-key [f5]               'delete-trailing-whitespace)
(global-set-key (kbd "<S-pause>")  "\M-l")
(global-set-key (kbd "<pause>")    "\M-u")
(global-set-key (kbd "<kp-enter>") 'goto-line)

(global-set-key [(control f3)]  'c++-mode)
(global-set-key [(control f4)]  'cmake-mode)
(global-set-key [(control f5)]  'f90-mode)
(global-set-key [(control f6)]  'org-mode)
(global-set-key [(control f7)]  'makefile-mode)
(global-set-key [(control f8)]  'shell-script-mode)
(global-set-key [(control f9)]  'cperl-mode)
(global-set-key [(control f10)] 'font-lock-mode)
(global-set-key [(control f11)] 'kpp-mode)

(global-set-key [(meta n)]      'scroll-n-lines-ahead)
(global-set-key [(meta p)]      'scroll-n-lines-behind)
(global-set-key [(control tab)] 'other-window)

(global-set-key [f6]          'find-file)
(global-set-key [(shift f6)]  'insert-file)
(global-set-key [f7]          'save-buffer)
(global-set-key [f8]          'isearch-forward)
(global-set-key [f9]          'replace-string)
(global-set-key [(shift f9)]  'query-replace)

(setq initial-major-mode 'fundamental-mode)

(setq auto-mode-alist
      (append '(("\\.cmake"      . cmake-mode)
                ("\\.c$"         . c-mode)
                ("\\.C$"         . c++-mode)
                ("\\.hh$"        . c++-mode)
                ("\\.hpp$"       . c++-mode)
                ("\\.cpp$"       . c++-mode)
                ("\\.h$"         . c++-mode)
                ("\\.hM$"        . c++-mode)
                ("\\.F$"         . fortran-mode)
                ("\\.H$"         . f90-mode)
                ("\\.F90$"       . f90-mode)
                ("\\.tex$"       . latex-mode)
                ("\\.m$"         . matlab-mode)
                ("\\.md$"        . markdown-mode)
                ("\\.org$"       . org-mode)
                ("\\.sh$"        . shell-script-mode)
                ("\\.env$"       . shell-script-mode)
                ("\\.centos7$"   . shell-script-mode)
                ("\\.pl$"        . cperl-mode)
                ("\\.rc$"        . conf-mode)
                ("\\.yaml$"      . yaml-mode)
                ("\\.yml$"       . yaml-mode)
                )auto-mode-alist))

(add-to-list 'auto-mode-alist '(".bash_profile"         . shell-script-mode))
(add-to-list 'auto-mode-alist '(".bashrc"               . shell-script-mode))
(add-to-list 'auto-mode-alist '(".bash_aliases"         . shell-script-mode))
(add-to-list 'auto-mode-alist '(".my_personal_settings" . shell-script-mode))
(add-to-list 'auto-mode-alist '(".README"               . fundamental-mode))
(add-to-list 'auto-mode-alist '("input.geos"            . conf-mode))

(auto-image-file-mode)

(setq perl-indent-level 2)
(setq perl-continued-statement-offset 2)

(setq perl-tab-to-comment t)

(setq perl-electric-parens t)
(setq perl-electric-keywords t)

(setq ediff-split-window-function 'split-window-vertically)

(defun update-diff-colors ()
  "update the colors for diff faces"
  (set-face-attribute 'diff-added nil
                      :foreground "black" :background "DarkSeaGreen1")
  (set-face-attribute 'diff-removed nil
                      :foreground "black" :background "RosyBrown1")
  (set-face-attribute 'diff-changed nil
                      :foreground "black" :background "wheat1"))
(eval-after-load "diff-mode"
  '(update-diff-colors))

(defalias 'clean-after-ediff
  (read-kbd-macro "C-x 1 C-x 3 C-x b RET"))

(defalias 'fullcleanediff
  (read-kbd-macro "<f3> <f2> <f3>"))

(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1)          ; GNU Emacs
    (setq font-lock-auto-fontify t))   ; XEmacs

(add-hook 'f90-mode-hook
          (function
           (lambda ()

             ;; use abbreviations (e.g.: "`pr" for "print")
             (setq  abbrev-mode 1)

             ; Turn off automatic indentation for Fortran mode only
             (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

             )
           )
          )

(fset 'smart-f90-tab
   [home ?  tab end])

(require 'f90)

(add-hook 'fortran-mode-hook
          (function
           (lambda ()
             (setq
              ;; use abbreviations (e.g.: ";s" for "stop")
              abbrev-mode 1
              )

             ; Turn off automatic indentation for Fortran mode only
             (when (fboundp 'electric-indent-mode) (electric-indent-mode -1))
             )
           )
)

(require 'fortran)

(require 'markdown-mode)

(require 'org)

(setq org-startup-indented t)

(setq org-hide-leading-stars t)

(setq org-odd-levels-only t)

(setq org-src-tab-acts-natively t)

(setq org-hide-emphasis-markers t)

(setq org-fontify-done-headline t)

(setq org-log-done 'time)

(setq org-pretty-entities nil)

(setq org-structure-template-alist
  '(("a" . "export ascii\n")
    ("c" . "center\n")
    ("C" . "comment\n")
    ("e" . "example\n")
    ("E" . "export")
    ("h" . "export html\n")
    ("l" . "export latex\n")
    ("q" . "quote\n")
    ("s" . "src")
    ("v" . "verse\n")))

(if (file-directory-p "~/org")
    (setq org-agenda-files (list "~/org/home.org"
                                 "~/org/work.org")))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-columns-default-format "%50ITEM(Task) %10CLOCKSUM %16TIMESTAMP_IA")

(add-hook 'shell-mode-hook
	  '(lambda ()
             (local-set-key [home] 'comint-bol)                ;; Home key

	     (local-set-key [up]                                 ;; Cycle up
                            '(lambda () (interactive)          ;; through
                               (if (comint-after-pmark-p)      ;; command
                                   (comint-previous-input 1)   ;; history
                                 (previous-line 1))))

	     (local-set-key [down]                               ;; Cycle down
                            '(lambda () (interactive)          ;; through
                               (if (comint-after-pmark-p)      ;; command
                                   (comint-next-input 1)       ;; history
                                 (forward-line 1))))
             )
)

(add-hook 'text-mode-hook 'turn-on-auto-fill)

(defun joc-bounce-sexp ()
  "Will bounce between matching parens just like % in vi"
  (interactive)
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
        (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
                  ((string-match "[\]})>]" prev-char) (backward-sexp 1))
                  (t (error "%s" "Not on a paren, brace, or bracket")))))
(global-set-key [(control =)] 'joc-bounce-sexp)

(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

(defun scroll-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default)."
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))

(global-set-key [(control shift n)] (lambda () (interactive) (next-line 10)))
(global-set-key [(control shift p)] (lambda () (interactive) (previous-line 10)))

(setq scroll-step 1)

(setq mouse-wheel-scroll-amount '(3 ((shift) . 3) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(unless enable-vterm
  (defun ash-term-hooks ()
    ;; dabbrev-expand in term
    (define-key term-raw-escape-map "/"
      (lambda ()
        (interactive)
        (let ((beg (point)))
          (dabbrev-expand nil)
          (kill-region beg (point)))
        (term-send-raw-string (substring-no-properties (current-kill 0)))))
    ;; yank in term (bound to C-c C-y)
    (define-key term-raw-escape-map "\C-y"
      (lambda ()
        ((insert )nteractive)
        (term-send-raw-string (current-kill 0)))))
  (add-hook 'term-mode-hook 'ash-term-hooks)
)

(unless enable-vterm
  (defadvice term-sentinel (around my-advice-term-sentinel (proc msg))
    (if (memq (process-status proc) '(signal exit))
        (let ((buffer (process-buffer proc)))
          ad-do-it
          (kill-buffer buffer))
      ad-do-it))
  (ad-activate 'term-sentinel)
  )

(unless enable-vterm
  (defvar my-term-shell "/bin/bash")
  (defadvice term (before force-bash)
    (interactive
     (list my-term-shell)))
  (ad-activate 'term)
  )

(unless enable-vterm
  (defun my-term-use-utf8 ()
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
  (add-hook 'term-exec-hook 'my-term-use-utf8)
  )

(unless enable-vterm
  (defun last-term-buffer (l)
    "Return most recently used term buffer."
    (when l
          (if (eq 'term-mode (with-current-buffer (car l) major-mode))
              (car l) (last-term-buffer (cdr l)))))
)

(unless enable-vterm
  (defun get-term ()
    (interactive)
    (let ((b (last-term-buffer (buffer-list))))
          (if (or (not b) (eq 'term-mode major-mode))
              (multi-term)
            (switch-to-buffer b))))
)

(unless enable-vterm
  (defun term-send-kill-whole-line ()
    (interactive)
    (term-send-raw-string "\C-a")
    (term-send-raw-string "\C-k"))
  )

(unless enable-vterm
  (defun unique-bash-term ()
    (interactive)
    (set-buffer (make-term "terminal" my-term-shell))
    (term-mode)
    (term-char-mode)
    (switch-to-buffer "*terminal*")
    (rename-uniquely)
    )
  )

(unless enable-vterm
  (setq multi-term-program "/bin/bash")
  (setq term-unbind-key-list '("C-x" "<ESC>"))
  (setq term-bind-key-alist
        '(("C-c" . term-interrupt-subjob)
          ("C-p" . term-send-up)
          ("C-n" . term-send-down)
          ("C-s" . isearch-forward)
          ("C-r" . term-send-reverse-search-history)
          ("C-m" . term-send-raw)
          ("C-k" . term-send-kill-whole-line)
          ("C-y" . yank)
          ("C-_" . term-send-raw)
          ("M-f" . term-send-forward-word)
          ("M-b" . term-send-backward-word)
          ("M-K" . term-send-kill-line)
          ("M-p" . previous-line)
          ("M-n" . next-line)
          ("M-y" . yank-pop)
          ("M-." . term-send-raw-meta)))

  (global-set-key (kbd "C-q") 'unique-bash-term)
  (global-set-key (kbd "C-;") "\C-c \C-j") ;; Line mode
  (global-set-key (kbd "C-'") "\C-c \C-k") ;; Char mode
  (define-key global-map (kbd "C-x e") 'multi-term)
  )

(when enable-vterm
  (add-to-list 'load-path "~/.emacs.d/emacs-config/emacs-libvterm")
  (require 'vterm)
)

(when enable-vterm
  (defadvice vterm-sentinel (around my-advice-vterm-sentinel (proc msg))
    (if (memq (process-status proc) '(signal exit))
        (let ((buffer (process-buffer proc)))
          ad-do-it
          (kill-buffer buffer))
      ad-do-it))
  (ad-activate 'vterm-sentinel)
)

(when enable-vterm
  (defvar my-vterm-shell "/bin/bash")
  (defadvice vterm (before force-bash)
    (interactive
     (list my-vterm-shell)))
  (ad-activate 'vterm)
)

(when enable-vterm
  (defun my-vterm-use-utf8 ()
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
  (add-hook 'vterm-exec-hook 'my-vterm-use-utf8)
)

(when enable-vterm
  (defun last-vterm-buffer (l)
    (when l
          (if (eq 'vterm-mode (with-current-buffer (car l) major-mode))
              (car l) (last-vterm-buffer (cdr l)))))
)

(when enable-vterm
  (defun get-vterm ()
    (interactive)
    (let ((b (last-vterm-buffer (buffer-list))))
          (if (or (not b) (eq 'vterm-mode major-mode))
              (multi-vterm)
            (switch-to-buffer b))))
)

(when enable-vterm
  (defun vterm-send-kill-whole-line ()
    (interactive)
    (vterm-send-raw-string "\C-a")
    (vterm-send-raw-string "\C-k"))
  (defun vterm-send-kill-line ()
    (interactive)
    (vterm-send-raw-string "\C-k"))
)

(when enable-vterm
  (defun unique-bash-vterm ()
    (interactive)
    (vterm)
    (vterm-send-key "<escape>")
    (rename-uniquely))
)

(when enable-vterm
  (global-set-key [(control f1)] 'unique-bash-vterm)
  (global-set-key (kbd "C-q") 'unique-bash-vterm)
  (define-key global-map (kbd "C-x e") 'multi-vterm)
)
