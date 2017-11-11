(require 'cl-lib)
(require 'shr)
(require 'url-parse)
(require 'browse-url)

(require 'message) ; faces

(defvar emacs-feed-show-mode-map
  (let ((map (make-sparse-keymap)))
    (prog1 map
      (suppress-keymap map)
      (define-key map "q" 'quit-window)
      ))
  )

(defun emacs-feed-show-mode ()
  "Mode for displaying Elfeed feed entries.
\\{elfeed-show-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (use-local-map emacs-feed-show-mode-map)
  (setq major-mode 'emacs-feed-show-mode-map
        mode-name "emacs-feed-show"
        buffer-read-only t)
  (buffer-disable-undo)
  (make-local-variable 'emacs-feed-show-entry)
  (run-hooks 'emacs-feed-show-mode-hook))


(defun feedjs-show-entry (entry)
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
    (switch-to-buffer (get-buffer-create (format "* feed %s*" title)))
    (unless (eq major-mode 'emacs-feed-show-mode-map)
      (emacs-feed-show-mode))
    (setq emacs-feed-show-entry entry)
    (feed-show-refresh)))

(defun emacs-feed-libxml-supported-p ()
  "Return non-nil if `libxml-parse-html-region' is available."
  (with-temp-buffer
    (insert "<html></html>")
    (and (fboundp 'libxml-parse-html-region)
         (not (null (libxml-parse-html-region (point-min) (point-max)))))))

(defun emacs-feed-insert-html (html)
  (shr-insert-document
   (if (emacs-feed-libxml-supported-p)
       (with-temp-buffer
         ;; insert <base> to work around libxml-parse-html-region bug

         (insert html)
         (libxml-parse-html-region (point-min) (point-max))
         )
     '(i () "Elfeed: libxml2 functionality is unavailable"))))

(cl-defun feedjs-insert-link (url &optional (content url))
  "Insert a clickable hyperlink to URL titled CONTENT."
  (when (and (integerp shr-width)
             (> (length content) (- shr-width 8)))
    (let ((len (- (/ shr-width 2) 10)))
      (setq content (format "%s[...]%s"
                            (substring content 0 len)
                            (substring content (- len))))))
  (emacs-feed-insert-html (format "<a href=\"%s\">%s</a>" url content)))

(defun erase-junk-char ()
  (while (re-search-forward "" nil t)
    (replace-match "")))

(defun feed-show-refresh ()
  (interactive)
  (let* ((inhibit-read-only t)
         (title (plist-get entry ':title))
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
    (erase-buffer)
    (insert (format (propertize "Title: %s\n" 'face 'message-header-name)
                    (propertize title 'face 'message-header-subject)))
    ;; (insert (format (propertize "Date: %s\n" 'face 'message-header-name)
    ;;                 (propertize date 'face 'message-header-other)))

    (insert (propertize "Link: " 'face 'message-header-name))

    (feedjs-insert-link link link)
    (insert "\n")

    (emacs-feed-insert-html content)

    (goto-char (point-min))
    (erase-junk-char)
    (goto-char (point-min))
    )
  )

(provide 'emacs-feedjs-show)
