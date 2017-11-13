;;; packages.el --- feedjs Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2017 Fangwei chen
;;
;; Author: Fangwei Chen <chenfangwei@outlook.com>
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3 

(defconst feedjs-packages
  '(
    (emacs-feedjs :location local) 
    ))

(defun feedjs/init-emacs-feedjs ()
  "Initialize feedjs"
  (use-package emacs-feedjs
    :commands (feedjs)
    :defer t
    :init
    (progn
      (spacemacs/set-leader-keys
        "aFf" 'feedjs
        )
      )
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'feedjs-search-mode "af" "feedjs")
      (spacemacs/set-leader-keys-for-major-mode 'feedjs-search-mode
        "afu" 'feedjs-search-fetch-unread
        "afr" 'feedjs-search-refresh
        )
      (evil-define-key 'normal feedjs-search-mode-map
        (kbd "r") 'feedjs-search-refresh
        (kbd "x") 'feedjs-search-mark-atom-has-read
        (kbd "o") 'feedjs-jump-to-atom-href
        (kbd "<return>") 'feedjs-search-show-entry
        (kbd "u") 'feedjs-search-fetch-unread)
      (evil-define-key 'normal feedjs-show-mode-map
        (kbd "q") 'quit-window)
     )))

;;; packages.el ends here
