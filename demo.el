(setq demo-dir (file-name-directory (or load-file-name (buffer-file-name))))

(setq org-directory demo-dir)

;; Enable org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (ditaa . t)
   (sh . t)))


(global-set-key (kbd "C-c a") 'org-agenda)

;; Set agenda files
(setq org-agenda-files (expand-file-name 
			"agenda-files.org"
			demo-dir))

;; Refile targets
; Targets include this file and any file contributing to the agenda -
; up to 5 levels deep
(setq org-refile-targets 
      (quote ((org-agenda-files :maxlevel . 5) 
              (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete in steps so we start with filename, TAB shows the
; next level of targets etc
(setq org-outline-path-complete-in-steps t)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))



;; Capture templates
(require 'org-capture)
(global-set-key (kbd "C-M-r") 'org-capture)
  
(setq org-capture-templates
      '(("t" "task" entry
         (file+headline "refile.org" "Tasks")
         "* TODO %? \n  ")
        ("x" "org-protocol save relevant links" item
         (clock)
         "+ [[%:link][%:description]]" :immediate-finish t)
        ("w" "org-protocol bookmarks" entry
         (file+headline "refile.org" "Links")
         "* %:description %^G:\n  %u\n  %:link\n\n  %:initial" 
	 :immediate-finish t)))

;; org-protocol
(require 'org-protocol)

;; start emacs server for org-protocol
(server-start)  
