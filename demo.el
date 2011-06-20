(setq demo-dir (file-name-directory (or load-file-name (buffer-file-name))))

(setq org-directory demo-dir)

;; Enable org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (ditaa . t)
   (sh . t)))

;; Set agenda files
(setq org-agenda-files (expand-file-name 
			"agenda-files.org"
			demo-dir))

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
