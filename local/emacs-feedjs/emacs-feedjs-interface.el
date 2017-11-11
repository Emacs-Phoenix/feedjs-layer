(require 'json)
(require 'request)
(require 'emacs-feedjs-notifiy)
(require 'emacs-feedjs-face)
(require 'web)


(defvar feedjs--listen-input-buffer "*FeedJs-Listen-Input*")

(defvar feedjs--process-name "FeedJs")

(defvar feedjs--process-var nil)


(defvar server-address "localhost:7788")
(defvar server-url (concat "http://" server-address))

(defun feedjs-start-process ()
  (interactive)
  (if feedjs--process-var
      (message "feedjs readly running")
    (progn
      (message "start Feedjs Process")
      (setq feedjs--process-var (start-process feedjs--process-name feedjs--listen-input-buffer
                                               "node" feedjs--process "--emacs")))))

(defun feedjs-process-running? ()
  (interactive)
  (if feedjs--process-var
      t
    nil))

(defun feedjs-kill-process ()
  (interactive)
  (if feedjs--process-var
      (progn
        (delete-process feedjs--process-var)
        (setq feedjs--process-var nil)
        (with-current-buffer feedjs--listen-input-buffer
          (erase-buffer)))))

(defun feedjs-restart-process ()
  (interactive)
  (feedjs-kill-process)
  (feedjs-start-process))

(defun extraction-entry-from-buffer (add-fn)
  (save-excursion
    (with-current-buffer feedjs--listen-input-buffer
      (let ((json-object-type 'plist))
        (unwind-protect
            (when (check-input-buffer-empty)
              (progn
                (funcall add-fn (plist-get (json-read-from-string (buffer-string))
                                                       ':title))
                (goto-char (point-min))
                (delete-region (point-min) (line-end-position))
                (goto-char (point-min))
                (delete-char 1)
                (extraction-entry-from-buffer add-fn)
                )))))))

(defun check-input-buffer-empty ()
  "检查程序输入 buffer 是否为空"
  ;;(not (eq nil (get-buffer feedjs--listen-input-buffer)))
  (> (buffer-size) 0))

(defun check-input-buffer-not-empty ()
  "检查程序输入 buffer 是否不为空."
  (not (check-input-buffer-empty)))

(defun request-server-get-feed (url)
  (web-http-get
   (lambda (http header my-data)
     (let* ((json-object-type 'plist)
            (entries  (json-read-from-string (decode-coding-string my-data 'utf-8) ) ))
       (feedjs-search-entries-clean)
       (mapcar (lambda (entry2)
                 (feedjs-add-entry entry2))
               entries)))
   :url url))

(defun new-feed-from-server-url (number)
  (request-server-get-feed
   (concat server-url "/new/" (number-to-string number))))

(defun mark-atom-has-read (id)
  (web-http-post
   (lambda (con header data)
     data)
   :url (concat server-url "/unread/" (number-to-string id))))

(defun new-unread-feed-from-server-url (number)
  (request-server-get-feed
   (concat server-url "/new-unread/" (number-to-string number))))

(provide 'emacs-feedjs-interface)
