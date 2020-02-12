(setq $settings (list
                  (cons 'root "c:/mphillips/toolkit/")
                  (cons 'dir '("cmd"))
                )
)
(defun get_files ()
  (apply
    'append
  (mapcar
    '(lambda (x)
      (vl-directory-files
        (strcat
          (cdr (assoc 'root $settings))
          x
        )
        "*.lsp"
      )
    )
    (cdr (assoc 'dir $settings))
  )
  )
)
(defun add_directory_to_files ()
  (mapcar
    '(lambda (x)
      (strcat
        (cdr (assoc 'root $settings))
        x
      )
    )
    (get_files)
  )
)
(mapcar
  '(lambda (x)
    (princ x)
    (setq f (open x "r")
    
    (while (setq l (read-line f))
      (if (wcmatch l "(defun c:")
        (princ (strcat "\n" l))
        ""
      )
    )
  )
  (add_directory_to_files)
)
