(defface feedjs-notifiy-face
  '((((class color) (background light)) (:foreground "#aaa" :background "white"))
    (((class color) (background dark))  (:foreground "#77a" :background "white")))
  "Face used in search mode for dates."
  :group 'feedjs)

(setq notify-queue '())

(setq notify-timer nil)

(defvar extract-timer nil "Timer for extrante entries form input buffer.")

(defvar feedjs-notify-interval 7)
(defvar feedjs-extract-interval 10)

(defun add-to-feedjs-notify-queue (title)
  (add-to-list 'notify-queue title))

(defun show-notify-to-message ()
  (interactive)
  (let ((feed-title (pop notify-queue)))
    (when feed-title
      (message "%s" (concat (propertize "FeedJs Notifiy:" 'face '(:foreground "white" :background "green"))
                            " "
                            (propertize feed-title 'face 'feedjs-notifiy-face)
                            "      "
                            (propertize (concat "remain new atom: " (number-to-string (length notify-queue))) 'face '(:foreground "black" :background "yellow")))
                            ))))

(defun feedjs-start-notify ()
  (interactive)
  (if extract-timer
    (progn
      (unless notify-timer
        (progn
          (message "Start notify feedjs")
          (setq notify-timer
                (run-at-time t feedjs-notify-interval 'show-notify-to-message)))))
    (feedjs-start-extract-timer)))

(defun feedjs-stop-notify ()
  (interactive)
  (if notify-timer
    (progn
      (cancel-timer notify-timer)
      (message "Cancel nofity."))
    (message "timer not running.")))

(defun extraction-entry-from-buffer-to-notify ()
  (extraction-entry-from-buffer #'add-to-feedjs-notify-queue))

(defun feedjs-restart-extract-timer ()
  "Restart feedjs extract timer."
  (progn (feedjs-stop-extract-timer)
         (feedjs-start-extract-timer)))

;; 定时抽取
(defun feedjs-start-extract-timer ()
  "Start feedjs extract timer."
  (interactive)
  (if extract-timer
      (feedjs-restart-extract-timer)
    (progn
      (message "Timer extract-timer start!")
      (setq extract-timer
            (run-at-time t feedjs-extract-interval 'extraction-entry-from-buffer-to-notify)))))

(defun feedjs-stop-extract-timer ()
  "Stop feedjs extract timer."
  (interactive)
  (when extract-timer
    (progn
      (cancel-timer extract-timer)
      (message "Cancel Timer extract timer."))))

(provide 'emacs-feedjs-notifiy)
