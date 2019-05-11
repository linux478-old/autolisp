; alias command for the copy command and put in multiple mode
(defun c:c ()
  (command "copy"
           (ssget)
           ""
           "multiple"
  )
  (while (= (getvar "cmdactive") 1)
    (command pause)
  )
  (princ)
)
