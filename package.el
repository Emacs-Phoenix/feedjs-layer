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
    emacs-feedjs
    ))

(defun feedjs/init-slack ()
  "Initialize Slack"
  (use-package emacs-feedjs
    :commands (feedjs)
    :defer t
    :init
    (progn
      (spacemacs/set-leader-keys
        "aCs" 'slack-start
        "aCj" 'slack-channel-select
        "aCd" 'slack-im-select
        "aCq" 'slack-ws-close)
      (setq slack-enable-emoji t))
    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'feedjs-mode
        "j" 'slack-channel-select
        "d" 'slack-im-select
        "p" 'slack-room-load-prev-messages
        "e" 'slack-message-edit
        "q" 'slack-ws-close
        "mm" 'slack-message-embed-mention
        "mc" 'slack-message-embed-channel
        "k" 'slack-channel-select
        "@" 'slack-message-embed-mention
        "#" 'slack-message-embed-channel)
      (evil-define-key 'insert slack-mode-map
        (kbd "@") 'slack-message-embed-mention
        (kbd "#") 'slack-message-embed-channel))))
