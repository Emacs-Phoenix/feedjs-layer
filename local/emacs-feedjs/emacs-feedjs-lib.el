
(defun feedjs-format-column (string width &optional align)
  "Return STRING truncated or padded to WIDTH following ALIGNment
 Align should be a keyword :left or :right."
  (if (<= width 0)
      ""
    (format (format "%%%s%d.%ds" (if (eq align :left) "-" "") width width)
            string)))


(defun feedjs-clamp (min value max)
  "Clamp a value between two values."
  (min max (max min value)))



(provide 'emacs-feedjs-lib)
