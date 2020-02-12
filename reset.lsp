(setq $settings (list
                  (cons 'root "C:/folder/")
                  (cons 'directories '("/cmd" "/lib")
                )
)
(mapcar '(lambda (fs)
    (mapcar '(lambda (f / file_ptr cnt text_line $s)
           (setq file_ptr (open f "r"))
           (if file_ptr
             (progn
               (setq cnt 1)
               (while (setq text_line (read-line file_ptr))
                 (if (wcmatch text_line "(defun *")
                   (progn
                     (setq text_line (substr 
                                       text_line
                                       (setq $s (+ 2 (vl-string-position (ascii " ") text_line)))
                                       (1+ (- (vl-string-position (ascii "(") text_line 1) $s))
                                     )
                     )
                     (while (= (ascii " ") (car (reverse (vl-string->list text_line))))
                            (setq text_line (substr text_line 1 (1- (strlen text_line))))
                     )
                     (set (read text_line) nil)
                   )
                 )
                 (setq cnt (1+ cnt))
               )
               (close file_ptr)
             )
           )
        )
        fs
    )
  )
      (mapcar '(lambda (d)
           (mapcar '(lambda (f)
                      (strcat (cdr (assoc 'root $settings)) d "/" f)
                    );lambda add root and directory to file name
                   (vl-directory-files
                     (strcat
                       (cdr (assoc 'root $settings))
                       d
                     );strcat
                     "*.lsp"
                   );vl-directory-files gets lsp files
          );mapcar
         );lambda
         (cdr (assoc 'directories $settings))
       );mapcar
)
(setq $settings nil)
(princ)
