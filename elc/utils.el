(defmacro defpackages (packages)
  (declare (indent 1))
  `(dolist (p ,packages)
    (when (not (package-installed-p p))
      (package-install p))))
