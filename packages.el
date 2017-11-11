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
        "aFu" 'feedjs-search-fetch-unread
        "aFr" 'feedjs-search-refresh
        )
      )
    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'feedjs-search-mode
        "u" 'feedjs-search-fetch-unread
        "r" 'feedjs-search-refresh
        "return" 'feedjs-search-show-entry)
      (spacemacs/set-leader-keys-for-major-mode 'feedjs-show-mode
        "q" 'quit-window)
     )))

;;; packages.el ends here
