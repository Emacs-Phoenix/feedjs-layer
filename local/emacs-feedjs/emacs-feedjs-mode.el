



;; (defvar emacs-feedjs-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (prog1 map
;;       (suppress-keymap map)
;;       (define-key map "q" 'quit-window)))
;;   "Keymap for emacs-feedjs-mode.")

;; ;; (defun feedjs-show-entry (entry)
;; ;;   "Display ENTRY in the current buffer."
;; ;;   (let ((title (plist-get entry ':title)))
;; ;;     (switch-to-buffer (get-buffer-create (format "*feedjs %s" title)))
;; ;;     (unless (eq major-mode 'emacs-feedjs-mode)
;; ;;       (emacs-feedjs-mode))
;; ;;     (setq emacs-feedjs-entry entry)
;; ;;     (emacs-feedjs-mode-refresh)))

;; (defun emacs-feedjs-mode ()
;;   "Magor mode for listing feed."
;;   (interactive)
;;   (kill-all-local-variables)
;;   (use-local-map emacs-feedjs-mode-map)
;;   (setq major-mode 'emacs-feedjs-mode
;;         mode-name "emacs-feedjs"
;;         truncate-lines t
;;         buffer-read-only t)
;;   (buffer-disable-undo)
;;   (hl-line-mode);highlight-changes-mode
;;   (make-local-variable 'emacs-feedjs-entry)
;;   (make-local-variable 'emacs-feedjs-filter)
;;   ;;(add-hook 'feedjs-update-hooks #'emacs-feedjs-update)
;;   (run-hooks 'elfeed-search-mode-hooks))

;; (defun emacs-feedjs-mode-refresh ()
;;   "Update the buffer to match the selected entry."
;;   (interactive)
;;   (erase-buffer))




;; (provide 'emacs-feedjs-mode)
