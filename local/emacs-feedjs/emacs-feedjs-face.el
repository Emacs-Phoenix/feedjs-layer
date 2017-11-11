(defface feedjs-search-date-face
  '((((class color) (background light)) (:foreground "#aaa"))
    (((class color) (background dark))  (:foreground "#77a")))
  "Face used in search mode for dates."
  :group 'feedjs)

(defface feedjs-search-title-face
  '((((class color) (background light)) (:foreground "#000"))
    (((class color) (background dark))  (:foreground "#fff")))
  "Face used in search mode for titles."
  :group 'feedjs)

(defface feedjs-search-unread-title-face
  '((t :inherit feedjs-search-title-face :weight bold))
  "Face used in search mode for unread entry titles."
  :group 'feedjs)

(defface feedjs-search-author-face
  '((((class color) (background light)) (:foreground "#aa0"))
    (((class color) (background dark))  (:foreground "#982Baa")))
  "Face used in search mode for feed titles."
  :group 'feedjs)

(defface feedjs-search-feed-face
  '((((class color) (background light)) (:foreground "#aa0"))
    (((class color) (background dark))  (:foreground "#ff0")))
  "Face used in search mode for feed titles."
  :group 'feedjs)

(defface feedjs-search-tag-face
  '((((class color) (background light)) (:foreground "#070"))
    (((class color) (background dark))  (:foreground "#0f0")))
  "Face used in search mode for tags."
  :group 'feedjs)

(defface feedjs-search-ascii-face
  '((((class color) (background light)) (:foreground "#070"))
    (((class color) (background dark))  (:foreground "#25E70f")))
  "Face used in search mode for tags."
  :group 'feedjs)

;;---
(defface feedjs-search-date-face-b
  '((((class color) (background light)) (:foreground "#aaa" :background "#a0ee76"))
    (((class color) (background dark))  (:foreground "#77a" :background "#a0ee76")))
  "Face used in search mode for dates."
  :group 'feedjs)

(defface feedjs-search-title-face-b
  '((((class color) (background light)) (:foreground "#000" :background "#a0ee76"))
    (((class color) (background dark))  (:foreground "#fff" :background "#a0ee76")))
  "Face used in search mode for titles."
  :group 'feedjs)

(defface feedjs-search-unread-title-face-b
  '((t :inherit feedjs-search-title-face :weight bold :background "#a0ee76"))
  "Face used in search mode for unread entry titles."
  :group 'feedjs)

(defface feedjs-search-author-face-b
  '((((class color) (background light)) (:foreground "#aa0" :background "#a0ee76"))
    (((class color) (background dark))  (:foreground "#982Baa" :background "#a0ee76")))
  "Face used in search mode for feed titles."
  :group 'feedjs)

(defface feedjs-search-feed-face-b
  '((((class color) (background light)) (:foreground "#aa0" :background "#a0ee76"))
    (((class color) (background dark))  (:foreground "#ff0" :background "#a0ee76")))
  "Face used in search mode for feed titles."
  :group 'feedjs)

(defface feedjs-search-tag-face-b
  '((((class color) (background light)) (:foreground "#070" :background "#a0ee76"))
    (((class color) (background dark))  (:foreground "#0f0" :background "#a0ee76")))
  "Face used in search mode for tags."
  :group 'feedjs)

(defface feedjs-search-ascii-face-b
  '((((class color) (background light)) (:foreground "#070" :background "#a0ee76"))
    (((class color) (background dark))  (:foreground "#25E70f" :background "#a0ee76")))
  "Face used in search mode for tags."
  :group 'feedjs)


(provide 'emacs-feedjs-face)
