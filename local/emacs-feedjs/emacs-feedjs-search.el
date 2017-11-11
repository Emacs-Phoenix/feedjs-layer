(require 'emacs-feedjs-show)
(require 'emacs-feedjs-face)

(defvar feedjs-search-show-n 100)

(defun feedjs-search-buffer ()
  (get-buffer-create "*feedjs-search*"))

;;---

(defvar feedjs-search--offset 1
  "Offset between line numbers and entry list position.")

(defvar feedjs-search-entries '())

(defvar feedjs-search-to-show-entries ())

(defvar feedjs-search-trailing-width 30
  "Space reserved for displaying the feed end tag information.")

(defvar feedjs-search-title-min-width 16)

(defvar feedjs-search-title-max-width 70)

(defun feedjs-add-entry (entry)
  ;; (setf feedjs-search-entries
  ;;       (append '(entry) feedjs-search-entries))
  (with-current-buffer (feedjs-search-buffer)
    (add-to-list 'feedjs-search-entries entry)))

(defvar feedjs-search-mode-map
  (let ((map (make-sparse-keymap)))
    (prog1 map
      (suppress-keymap map)
      (define-key map "q" 'quit-window)
      (define-key map (kbd "RET") 'feedjs-search-show-entry)
      (define-key map (kbd "r") 'feedjs-search-refresh)
      (define-key map (kbd "j") 'feedjs-jump-to-atom-href)
      (define-key map (kbd "C-x C-s") (lambda (message "can not save")))
      (define-key map (kbd "u") 'feedjs-search-fetch-unread)
      (define-key map (kbd "x") 'feedjs-search-mark-atom-has-read)
      (define-key map (kbd "k") 'feedjs-search-mark-atom-has-read)
      (define-key map "m" 'feedjs-search-show-entry))))

(defun feedjs-search-mode ()
  "Major mode for listing feed."
  (interactive)
  (kill-all-local-variables)
  (use-local-map feedjs-search-mode-map)
  (setq major-mode 'feedjs-search-mode
        mode-name "feedjs-search"
        truncate-lines t
        buffer-read-only t)
  (buffer-disable-undo)
  (hl-line-mode)
  (make-local-variable 'feedjs-search-entries)
  (run-hooks 'feedjs-search-mode-hook))

(defun feedjs-search-insert-header-text (text)
  "Insert TEXT into buffer using header face."
  (insert (propertize text 'facce '(widget-inactive italic))))

(defun feedjs-search-insert-header ()
  "Insert a one-line status header."
  (feedjs-search-insert-header-text
   "Feedjs Search...\n"))

(defun feedjs-search-entry-print (entry cn)
  "Print ENTRY to the buffer."
  (let* ((title (plist-get entry ':title))
         ;; (date (plist-get entry ':date))
         (author (concat (plist-get entry ':author) " "))
         (link (plist-get entry ':link))
         (content (plist-get entry ':content))

         ;;TODO add title unread faces and read faces
         ;;(title-faces (if ()))
         (title-width (- (window-width) 10 feedjs-search-trailing-width))
         (title-column (feedjs-format-column
                        title (feedjs-clamp
                               feedjs-search-title-min-width
                               title-width
                               feedjs-search-title-max-width)
                        :left)))
    (progn
      (insert (propertize "⊙" 'face 'feedjs-search-ascii-face))
      ;; (insert (propertize date 'face 'feedjs-search-date-face) " ")
      (insert (propertize title-column 'face 'feedjs-search-unread-title-face) "    ")
      (insert (propertize author 'face 'feedjs-search-author-face))
      (insert "\n"))
))


(defun feedjs-search-show-entry (entry)
  (interactive (list (feedjs-search-selected)))
  (when entry
    (feedjs-show-entry entry)))

(defun feedjs-jump-to-atom-href (entry)
  (interactive (list (feedjs-search-selected)))
  (when entry
    (browse-url (plist-get entry ':link))))

(defun feedjs-search-selected ()
  (let* ((line-index (line-number-at-pos))
         (offset (- line-index feedjs-search--offset 1)))
    (when (and (>= offset 0) (nth offset feedjs-search-entries))
      (nth offset feedjs-search-entries))))

(defun feedjs-search-entries-clean ()
  (with-current-buffer (feedjs-search-buffer)
    (setf feedjs-search-entries ())))

(defun feedjs-search-clean ()
  (interactive)
  (feedjs-search-entries-clean)
  (feedjs-search-redraw-all))

(defun feedjs-search-redraw-all ()
  (interactive)
  (with-current-buffer (feedjs-search-buffer)
    (let ((inhibit-read-only t)
          (entries feedjs-search-entries)
          (cn 0))
      (erase-buffer)
      (save-excursion
        (feedjs-search-insert-header)
        (dolist (entry entries)
          (feedjs-search-entry-print entry cn)
          (setq cn (+ cn 1)))
        (insert "End of entries.\n")
        ))))

(defun feedjs-search-refresh ()
  (interactive)
  (feedjs-search-redraw-all))

(defun feedjs-search-fetch-unread ()
  (interactive)
  (new-unread-feed-from-server-url feedjs-search-show-n))

(defun feedjs-search-new ()
  (interactive)
  (new-feed-from-server-url feedjs-search-show-n))

(defun feedjs-search-mark-atom-has-read (entry)
  (interactive (list (feedjs-search-selected)))
  (let ((line-index (line-number-at-pos)))
    (when entry
      (progn
        (mark-atom-has-read (plist-get entry ':id))
        (setf feedjs-search-entries (delete entry feedjs-search-entries))
        (feedjs-search-refresh)
        (forward-line (- line-index 1))
        ))))

(provide 'emacs-feedjs-search)
